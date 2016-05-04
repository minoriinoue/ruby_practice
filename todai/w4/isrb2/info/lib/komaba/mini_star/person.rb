require "komaba/mini_star/sprite"

module Komaba
  module MiniStar
    class Person < Sprite

      FPS = 30

      def initialize()
        super()
        @x = 20
        @y = 100
        @height = 100
        @color = [1.0, 1.0, 1.0]
        @right_arm_height_ratio = 0.0
        @visible = true
        redisplay_all_objects()
      end

      def height()
        @height
      end

      def height=(height)
        @height = height
        redisplay_all_objects()
      end

      def color()
        @color
      end

      def color=(color)
        @color = color
        redisplay_all_objects()
      end

      def right_arm_height_ratio()
        @right_arm_height_ratio
      end

      def right_arm_height_ratio=(v)
        @right_arm_height_ratio = v
        redisplay_all_objects()
      end
      
      def <(other)
        self.height < other.height
      end

      def <=(other)
        self.height <= other.height
      end

      def >(other)
        self.height > other.height
      end

      def >=(other)
        self.height >= other.height
      end

      def move(dst_x, dst_y, options = {})
        # begin parsing options
        if options[:time]
          frame = (options[:time] * FPS).to_i()
        elsif options[:speed]
          d = Math.sqrt((self.x - dst_x) ** 2 + (self.y - dst_y) ** 2)
          frame = ((d * FPS) / options[:speed]).to_i()
        else
          frame = 20
        end
        # end parsing options
        start_x = self.x
        start_y = self.y
        m = frame
        for i in 1..m
          ratio = i.to_f() / m
          x = (ratio * dst_x + (1 - ratio) * start_x).to_i()
          y = (ratio * dst_y + (1 - ratio) * start_y).to_i()
          self.set_xy(x, y)
        end
      end

      def flash(time = 1, color = [1, 0, 0])
        time_fps = time * FPS
        orig_color = Array.new(3)
        orig_color[0] = self.color[0]
        orig_color[1] = self.color[1]
        orig_color[2] = self.color[2]
        m = (time_fps / 3).to_i()
        for i in 1..m
          ratio = i.to_f() / m
          c = Array.new(3)
          c[0] = (1 - ratio) * orig_color[0] + ratio * color[0]
          c[1] = (1 - ratio) * orig_color[1] + ratio * color[1]
          c[2] = (1 - ratio) * orig_color[2] + ratio * color[2]
          self.color = c
        end
        m = (time_fps * 2 / 3).to_i()
        for i in 1..m
          ratio = i.to_f() / m
          c = Array.new(3)
          c[0] = (1 - ratio) * color[0] + ratio * orig_color[0]
          c[1] = (1 - ratio) * color[1] + ratio * orig_color[1]
          c[2] = (1 - ratio) * color[2] + ratio * orig_color[2]
          self.color = c
        end
      end

      def is_raising_hand()
        self.right_arm_height_ratio() == 1.0
      end
      
      def raise_hand()
        if self.is_raising_hand()
          return
        end
        m = 3
        for i in 1..m
          self.right_arm_height_ratio = i.to_f() / m
        end
      end
      
      def lower_hand()
        if self.right_arm_height_ratio() == 0.0
          return
        end
        m = 3
        for i in 1..m
          self.right_arm_height_ratio = 1 - i.to_f() / m
        end
      end

      def show()
        @visible = true
        redisplay_all_objects()
      end

      def hide()
        @visible = false
        redisplay_all_objects()
      end

      def is_visible()
        @visible
      end

      def display()
        if !self.is_visible
          return
        end
        # Head
        center_x = self.x
        center_y = self.y - self.height + 5
        render_filled_circle(center_x, center_y, 4, self.color)
        # Shoulder
        x = self.x - 10
        y = self.y - self.height + 10
        width = 20
        height = 5
        render_filled_rect(x, y, width, height, self.color)
        # Right Arm
        x = self.x - 10
        y = self.y - self.height + 10
        width = 4
        height = self.height / 2
        ratio = @right_arm_height_ratio
        height = height * (1 - ratio) + (-height) * ratio
        if height < 0
          y = y + height
          height = -height
        end
        render_filled_rect(x, y, width, height, self.color)
        # Left Arm
        x = self.x + 6
        y = self.y - self.height + 10
        width = 4
        height = self.height / 2
        render_filled_rect(x, y, width, height, self.color)
        # Body
        x = self.x - 5
        y = self.y - self.height + 10
        width = 10
        height = self.height / 2
        render_filled_rect(x, y, width, height, self.color)
        # Right Leg
        x = self.x - 5
        y = self.y - self.height + 10 + self.height / 2
        width = 4
        height = self.height - 10 - self.height / 2
        render_filled_rect(x, y, width, height, self.color)
        # Left Leg
        x = self.x + 1
        y = self.y - self.height + 10 + self.height / 2
        width = 4
        height = self.height - 10 - self.height / 2
         render_filled_rect(x, y, width, height, self.color)
      end

      def inspect()
        "#<#{self.class}>"
      end

    end
  end
end
