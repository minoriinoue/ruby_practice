require "komaba/renderable"

module Komaba
  class ObjectRenderer

    include StarRuby
    include Renderable

    attr_accessor :object
    attr_accessor :x
    attr_accessor :y
    attr_reader :font

    def initialize(object, x, y, font)
      @object = object
      @x = x
      @y = y
      @font = font
    end

    def on_rendered(texture)
      render_obj(texture, @object, @x, @y)
    end

    private

    VALUE_TYPES = [Numeric].freeze

    def value?(obj)
      VALUE_TYPES.any?{|v| obj.kind_of?(v)}
    end

    def render_obj(texture, object, ox, oy, level = 0)
      case object
      when Array
        render_array(texture, object, ox, oy, level)
      when Numeric
        render_numeric(texture, object, ox, oy, level)
      else
        render_object(texture, object, ox, oy, level)
      end
    end

    def render_array(texture, object, ox, oy, level)
      if level == 0 and object.any?{|e| !value?(e)}
        # vertical
        box_width = object.map{ |e|
          padding_x = 8 * 2
          if value?(e)
            [@font.get_size(e.inspect)[0] + padding_x, 32].max
          else
            32
          end
        }.max || 32
        object.size.times do |i|
          x1 = ox + 0
          x2 = ox + box_width - 1
          y1 = oy + i * 32
          y2 = oy + (i + 1) * 32 - 1
          color = Color.new(0xcc, 0xcc, 0xcc)
          texture.render_line(x1, y1, x2, y1, color)
          texture.render_line(x1, y2, x2, y2, color)
          texture.render_line(x1, y1, x1, y2, color)
          texture.render_line(x2, y1, x2, y2, color)
        end
        unique_children = []
        object.each do |o|
          if value?(o) or !unique_children.find{|c| c.equal?(o)}
            unique_children << o
          end
        end
        object.each_with_index do |e, i|
          if value?(e)
            x = ox
            y = oy + i * 32
            render_obj(texture, e, x, y, level + 1)
          else
            j = 0
            unique_children.each_with_index do |c, j2|
              if c.equal?(e)
                j = j2
                break
              end
            end
            top = oy - ((unique_children.size - 1) * 8) / 2
            x = ox + box_width + 8
            y = top + j * (32 + 8)
            # object
            i_first = 0
            object.each_with_index do |o, i2|
              if o.equal?(e)
                i_first = i2
                break
              end
            end
            if i == i_first
              render_obj(texture, e, x, y, level + 1)
            end
            # line
            color = Color.new(0x99, 0x99, 0xcc)
            line_x1 = ox + box_width / 2
            line_y1 = oy + i * 32 + 16
            line_x2 = x
            line_y2 = top + j * (32 + 8) + 16
            texture.render_line(line_x1, line_y1, line_x2, line_y2, color)
          end
        end
      elsif level < 2
        # horizontal
        x2 = ox - 1
        object.each_with_index do |e, i|
          x1 = x2 + 1
          #x2 = ox + (i + 1) * 32 - 1
          padding_x = 8 * 2
          x2 += [@font.get_size(e.inspect)[0] + padding_x, 32].max
          y1 = oy + 0
          y2 = oy + 32 - 1
          color = Color.new(0xcc, 0xcc, 0xcc)
          texture.render_line(x1, y1, x2, y1, color)
          texture.render_line(x1, y2, x2, y2, color)
          texture.render_line(x1, y1, x1, y2, color)
          texture.render_line(x2, y1, x2, y2, color)
          render_obj(texture, e, x1, oy, level + 1)
        end
      else
        render_object(texture, object, ox, oy, level)
      end
    end

    def render_numeric(texture, object, ox, oy, level)
      render_object(texture, object, ox, oy, level)
    end

    def render_object(texture, object, ox, oy, level)
      text = object.inspect
      width, height = *@font.get_size(text)
      padding_x = 8
      padding_y = (32 - height) / 2
      texture.render_text(text, ox + padding_x, oy + padding_y, @font, Color.new(0xcc, 0xcc, 0x33), true)
    end

  end
end
