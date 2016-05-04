require "rbconfig"
require "thread"
require "komaba/array_serializer"
require "komaba/array_view"
require "komaba/call_stack_view"
require "komaba/normal_serializer"
require "komaba/view"
require "komaba/view_proxy"

module Komaba
  class Model

    ViewSet = Struct.new(:view, :object, :last_rendered_object)

    class ViewSet
      def changed?
        # SystemStackError?
        object != last_rendered_object
      end
    end

    def initialize
      @multi_windows = Config::CONFIG["arch"] !~ /mswin|mingw/
    end

    def add_variable(obj, type)
      delete_disposed_view_sets
      unless view_sets.any?{|v| v.object.equal?(obj)}
        view_class, serializer = case type
                                 when :array;  [ArrayView, ArraySerializer]
                                 when :object; [View, NormalSerializer]
                                 end
        if serializer.serializable?(obj)
          view_set = ViewSet.new(ViewProxy.new(view_class, serializer), obj, nil)
          @last_view_set = view_set
          view_sets << view_set
        else
          warn("can't show the object")
        end
      end
      if view_set = view_sets.find{|v| v.object.equal?(obj)} and
        view_set.changed?
        update_view(view_set)
      end
    end

    def include_call_stack_method?(method)
      delete_disposed_view_sets
      !!view_sets.find do |v|
        v.object.kind_of?(Hash) and v.object[:method] == method
      end
    end

    def add_call_stack(method)
      view_set = view_sets.find do |v|
        v.object.kind_of?(Hash) and v.object[:method] == method
      end
      unless view_set
        node = {
          :parent => nil,
          :children => [],
        }
        obj = {:method => method, :nodes => node, :pointer => node}
        view_set = ViewSet.new(ViewProxy.new(CallStackView, NormalSerializer), obj, nil)
        @last_view_set = view_set
        view_sets << view_set
      end
      if view_set.changed?
        update_view(view_set)
      end
    end

    def push_call_stack(method, args)
      delete_disposed_view_sets
      if view_set = view_sets.find do |v|
          v.object.kind_of?(Hash) and v.object[:method] == method
        end
        current = view_set.object[:pointer]
        return unless current
        child = {
          :args => args,
          :result => nil,
          :parent => current,
          :children => [],
        }
        current[:children].push(child)
        view_set.object[:pointer] = child
        update_view(view_set)
      end
    end

    def pop_call_stack(method, result)
      delete_disposed_view_sets
      if view_set = view_sets.find do |v|
          v.object.kind_of?(Hash) and v.object[:method] == method
        end
        view_set.object[:pointer][:result] = result
        view_set.object[:pointer] = view_set.object[:pointer][:parent]
        update_view(view_set)
      end
    end

    def update_views
      delete_disposed_view_sets
      view_sets.select do |view_set|
        view_set.changed?
      end.each do |view_set|
        view_set.view.update(view_set.object)
        view_set.last_rendered_object = Marshal.load(Marshal.dump(view_set.object))
      end
    end

    def update_view(view_set)
      delete_disposed_view_sets
      view_set.view.update(view_set.object)
      view_set.last_rendered_object = Marshal.load(Marshal.dump(view_set.object))
    end

    def render_text(text, x, y)
      if @last_view_set and @last_view_set.view and !@last_view_set.view.disposed?
        @last_view_set.view.render_text(text, x, y)
      end
    end

    def checkpoint
      delete_disposed_view_sets
      view_sets.each do |view_set|
        view_set.view.checkpoint
      end
    end

    def dispose
      view_sets.each do |view_set|
        view_set.view.dispose
      end
    end

    private

    def view_sets
      @view_sets ||= []
    end

    def delete_disposed_view_sets
      view_sets.delete_if do |view_set|
        view_set.view.disposed?
      end
    end

  end
end
