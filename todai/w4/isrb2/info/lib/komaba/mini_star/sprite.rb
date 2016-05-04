require "forwardable"

module Komaba
  module MiniStar
    class AbstractSprite

      def initialize
        @screen = nil
      end

      attr_accessor :screen

      def display
        # do nothing
      end

      extend Forwardable

      def_delegators(:@screen,
                     :render_line,
                     :render_pixel,
                     :render_rect,
                     :render_filled_rect,
                     :render_text,
                     :render_circle,
                     :render_filled_circle,
                     :render_trapezoid,
                     :render_filled_trapezoid,
                     :paint_out)

      def self.methods_to_show
        @methods_to_show ||= []
      end


      def self.calling_method
        @calling_method
      end

      def self.calling_method=(v)
        @calling_method = v
      end

      def self.rendering?
        @method_rendering ||= false
      end

      def self.rendering=(v)
        @method_rendering = v
      end

      def self.method_added(name)
        if methods_to_show.include?(name) or
            !instance_methods.include?(name.to_s)
          return
        end
        methods_to_show << name
        m = instance_method(name)
        klass = self
        define_method(name) do |*args|
          if !AbstractSprite.rendering? and classes_visible?
            begin
              klass.calling_method = name
              15.times do
                redisplay_all_objects
              end
            ensure
              klass.calling_method = nil
            end
          end
          m.bind(self).call(*args)
        end
      end

    end

    class Sprite < AbstractSprite

      @@instances = []

      class << self
        include Enumerable

        def each
          @@instances.each do |item|
            yield item
          end
        end

      end

      def initialize
        super
        @x = 0
        @y = 0
        @@instances << self
        unless MiniStar.updatable?
          MiniStar.start
        end
        redisplay_all_objects()
      end

      attr_reader :x
      attr_reader :y

      def x=(x)
        @x = x
        redisplay_all_objects()
      end
      
      def y=(y)
        @y = y
        redisplay_all_objects()
      end

      def set_xy(x, y)
        @x = x
        @y = y
        redisplay_all_objects()
      end

    end

  end
end
