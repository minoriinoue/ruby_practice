module Komaba
  module MiniStar
    class Bitmap

      attr_reader :texture

      def initialize(texture)
        @texture = texture
      end

      def [](i, j)
        color_to_array(texture[i, j])
      end

      def []=(i, j, color)
        texture[i, j] = array_to_color(color)
      end

      alias get_pixel []
      alias set_pixel []=

      def clear
        texture.fill(Color.new(0, 0, 0))
      end

      def fill(color)
        texture.fill(array_to_color(color))
      end

      def height
        texture.height
      end

      def width
        texture.width
      end

      def render_line(x1, y1, x2, y2, color)
        texture.render_line(x1, y1, x2, y2, array_to_color(color))
      end

      def render_pixel(x, y, color)
        texture[x, y] = array_to_color(color)
      end

      def render_rect(x, y, width, height, color)
        return if width <= 0 or height <= 0
        texture.render_rect(x, y, width, height, array_to_color(color))
      end
      
      def render_filled_rect(x, y, width, height, color)
        return if width <= 0 or height <= 0
        filled_rect_texture = Texture.new(width, height)
        filled_rect_texture.fill(array_to_color(color))
        self.texture.render_texture(filled_rect_texture, x, y)
      end

      def render_text(text, x, y, size, color)
        font = (@@font ||= Hash.new do |hash, size|
                  hash[size] = Font.new(Bitmap.font_name, size)
                end)[size]
        texture.render_text(text, x, y, font, array_to_color(color), true)
      end

      def render_circle(x, y, radius, color)
        color = array_to_color(color)
        d = 3 - 2 * radius
        cy = radius
        texture[x, y + radius] = color
        texture[x, y - radius] = color
        texture[x + radius, y] = color
        texture[x - radius, y] = color
        cx = 0
        while cx <= cy
          if d < 0
            d += 6 + 4 * cx
          else
            d += 10 + 4 * cx - 4 * cy
            cy -= 1
          end
          texture[ cy + x,  cx + y] = color
          texture[ cx + x,  cy + y] = color
          texture[-cx + x,  cy + y] = color
          texture[-cy + x,  cx + y] = color
          texture[-cy + x, -cx + y] = color
          texture[-cx + x, -cy + y] = color
          texture[ cx + x, -cy + y] = color
          texture[ cy + x, -cx + y] = color
          cx += 1
        end
      end

      def render_filled_circle(x, y, radius, color)
        return if radius < 0
        filled_circle_texture = Texture.new(radius * 2 + 1, radius * 2 + 1)
        filled_circle_bitmap = Bitmap.new(filled_circle_texture)
        filled_circle_bitmap.render_circle(radius, radius, radius, color)
        filled_circle_bitmap.paint_out(radius, radius, color)
        self.texture.render_texture(filled_circle_texture,
                                    x - radius, y - radius)
      end

      def render_trapezoid(x, y, upper_width, lower_width, height, color)
        color = array_to_color(color)
        upper_x1 = x
        upper_y1 = y
        upper_x2 = upper_x1 + upper_width - 1
        upper_y2 = upper_y1
        lower_x1 = x + (upper_width - lower_width) / 2
        lower_y1 = y + height
        lower_x2 = lower_x1 + lower_width - 1
        lower_y2 = lower_y1
        self.texture.render_line(upper_x1, upper_y1, upper_x2, upper_y2, color)
        self.texture.render_line(lower_x1, lower_y1, lower_x2, lower_y2, color)
        self.texture.render_line(upper_x1, upper_y1, lower_x1, lower_y1, color)
        self.texture.render_line(upper_x2, upper_y2, lower_x2, lower_y2, color)
      end

      def render_filled_trapezoid(x, y, upper_width, lower_width, height, color)
        return if height == 0
        w, h = [upper_width, lower_width].max, height
        filled_trapezoid_texture = Texture.new(w, h)
        filled_trapezoid_bitmap = Bitmap.new(filled_trapezoid_texture)
        ox = (upper_width - lower_width).abs / 2
        filled_trapezoid_bitmap.render_trapezoid(ox, 0, upper_width, lower_width, height, color)
        filled_trapezoid_bitmap.paint_out(w / 2, h / 2, color)
        self.texture.render_texture(filled_trapezoid_texture, x - ox, y)
      end
      
      def paint_out(x, y, color)
        texture.paint_out(x, y, array_to_color(color))
      end

      def render_sprite(sprite)
        orig_screen = sprite.screen
        sprite.screen = self
        sprite.display
      ensure
        sprite.screen = orig_screen
      end

      def self.font_name
        @font_name ||= ["/System/Library/Fonts/Thonburi.ttf",
                        "Arial",
                        "Bitstream Vera Sans, Roman",
                        "FreeSans,Medium"].each do |font_name|
          if Font.exist?(font_name)
            return font_name
          end
        end
      end
    end

    def array_to_color(color)
      unless color.kind_of?(Array)
        raise TypeError, "argument is not array"
      end
      if color.size != 3
        raise ArgumentError, "array size is not 3"
      end
      Color.new(*color[0, 3].map{|i| [[(i * 255).to_i, 0].max, 255].min})
    end

    def color_to_array(color)
      [color.red, color.green, color.blue].map{|i| i.quo(255)}
    end

  end
end


module ::StarRuby
  class Texture

    def paint_out(x, y, color)
      return unless 0 <= x and x < width and 0 <= y and y < height
      base_color = self[x, y]
      queue = []
      queue << [x, y] if base_color != color
      while request = queue.pop
        x, y = request
        l = r = x
        l -= 1 while 0 <= l-1 and self[l-1, y] == base_color
        r += 1 while r+1 < width and self[r+1, y] == base_color
        upper_addable = true
        lower_addable = true
        render_line(l, y, r, y, color)
        (l..r).each do |i|
          if 0 <= y-1
            if upper_addable
              if self[i, y-1] == base_color
                queue.unshift([i, y-1])
                upper_addable = false
              end
            elsif self[i, y-1] != base_color
              upper_addable = true
            end
          end
          if y+1 < height
            if lower_addable
              if self[i, y+1] == base_color
                queue.unshift([i, y+1])
                lower_addable = false
              end
            elsif self[i, y+1] != base_color
              lower_addable = true
            end
          end
        end
      end
    end

  end
end
