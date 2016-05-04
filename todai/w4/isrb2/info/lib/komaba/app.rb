require "rbconfig"

module Komaba
  class App

    def initialize(model)
      @model = model
      ::Kernel.module_eval do
        regexps = $LOAD_PATH.select{|p| p != "."}.map{|p| /^#{Regexp.escape(p)}/} + [/^(\.\/)?komaba\//]
        define_method(:enable_auto_updating) do
          unless @trace_func
            @trace_func = proc do |event, file, line, id, binding, klass|
              if %w(line call return c-call c-return).include?(event) and
                regexps.all?{|r| file !~ r}
                model.update_views
              end
            end
          end
          set_trace_func(@trace_func)
          nil
        end
        define_method(:disable_auto_updating) do
          set_trace_func(nil)
          nil
        end
        define_method(:show) do |obj|
          model.add_variable(obj, :array)
          nil
        end
        define_method(:show_object) do |obj|
          model.add_variable(obj, :object)
          nil
        end
        define_method(:show_call_stack) do |method, *args|
          unless (self.methods | self.private_methods).include?(method)
            warn("undefined method: #{method}")
            return nil
          end
          method = method.intern if method.kind_of?(String)
          if model.include_call_stack_method?(method)
            warn("now running!")
            return nil
          end
          model.add_call_stack(method)
          result = nil
          orig_method = "_orig_#{method}"
          begin
            (class << self; self end).instance_eval do
              alias_method(orig_method, method)
              define_method(method) do |*a|
                model.push_call_stack(method, a)
                result = __send__(orig_method, *a)
                model.pop_call_stack(method, result)
                result
              end
            end
            __send__(method, *args)
          ensure
            (class << self; self end).instance_eval do
              alias_method(method, orig_method)
            end
          end
          result
        end
        define_method(:text) do |text, x, y|
          model.render_text(text, x, y);
          return nil
        end
        define_method(:checkpoint_a) do
          model.checkpoint
          return nil
        end
        def method_missing(method, *args)
          if method.to_s =~ /^(.+)_CS$/ and
            (methods | private_methods).include?($1.to_s)
            show_call_stack($1, *args)
          else
            raise "undefined method `#{method}' for #{self}:#{self.class}"
          end
        end
      end

      def dispose
        set_trace_func(nil)
        @model.dispose
      end

    end
  end
end
