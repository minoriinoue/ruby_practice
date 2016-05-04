require "komaba/sr_view"
require "komaba/object_renderer"

module Komaba
  class CallStackView < SRView

    def initialize
      super(1000, 600, :title => "Call Stack", :cursor => true)
      @current_object = nil
    end

    def update
      begin
        super
        screen = game.screen
        screen.fill(Color.new(0x33, 0x33, 0x33))

        if [:playing, :init].include?(state) and !queue.empty? and time_to_update?
          @current_object = queue.pop
          end_init if state == :init
        end
        return unless @current_object

        render_node(screen, @current_object[:nodes], 8, screen.height - 40, screen.width - 16)
      ensure
        render_texts(screen)
        render_player(screen)
        update_screen
      end
    end

    private

    def array_or_inspect(obj)
      obj.kind_of?(Array) ? "Array" : obj.inspect
    end

    def render_node(screen, node, x, y, max_width)
      if node
        if node[:args] or node[:result]
          text = node[:args].map{|a| array_or_inspect(a)}.join(",") + "/" + array_or_inspect(node[:result])
          text_width = fonts[12].get_size(text)[0]
          if text_writable = text_width <= max_width
            text_padding = [max_width - text_width, 4].min / 2
            width = text_width + [max_width - text_width, 4].min
          else
            width = max_width
          end
        else
          text_writable = false
          width = [16, max_width].min
        end
        height = 18
        x1 = x + (max_width - width) / 2
        y1 = y
        x2 = x1 + width - 1
        y2 = y1 + height - 1
        if node[:args] or node[:result]
          box_front_color = Color.new(0xff, 0xff, 0xff)
        else
          box_front_color = Color.new(0x99, 0x99, 0x99)
        end
        box_border_color = Color.new(0x66, 0x66, 0x66)
        text_color = Color.new(0x33, 0x33, 0x33)
        screen.render_rect(x1, y1, width, height, box_front_color)
        if text_writable
          screen.render_text(text, x1 + text_padding, y1 + 2, fonts[12], text_color, true)
        end
        screen.render_line(x1, y1, x2, y1, box_border_color)
        screen.render_line(x1, y2, x2, y2, box_border_color) 
        screen.render_line(x1, y1, x1, y2, box_border_color) 
        screen.render_line(x2, y1, x2, y2, box_border_color) 
        connect_x1 = x1 + width / 2
        connect_y1 = y1
        connect_color = Color.new(0x66, 0x66, 0xcc)
        if children = node[:children] and !children.empty?
          node_width = max_width / children.size
          children.each_with_index do |child, i|
            child_x, child_y, child_w, child_h = render_node(screen, child, x + i * node_width, y - 30, node_width)
            connect_x2 = child_x + child_w / 2
            connect_y2 = child_y + child_h
            screen.render_line(connect_x1, connect_y1, connect_x2, connect_y2, connect_color)
          end
        end
        [x1, y1, width, height]
      else
        nil
      end
    end

  end
end
