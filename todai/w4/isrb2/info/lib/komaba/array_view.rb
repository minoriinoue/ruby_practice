require "thread"
require "komaba/sr_view"

module Komaba
  class ArrayView < SRView

    def initialize
      super(640, 640, :title => "Ruby", :cursor => true)
      @current_object = nil
    end

    def update
      begin
        super
        screen = game.screen
        screen.fill(Color.new(0x33, 0x33, 0xcc))

        if [:playing, :init].include?(state) and !queue.empty? and time_to_update?
          @current_object = queue.pop
          end_init if state == :init
        end
        return unless @current_object
        
        array = @current_object
        unless array.kind_of?(Array)
          warn("the object to show is not an array")
          return
        end
        return if array.size == 0
        array = [array] if array.any?{|row| !row.kind_of?(Array)}
        x_size = (array.map{|row| row.size}.max || 0)
        y_size = array.size
        
        cell_width  = [((screen.width  * 0.9) / x_size).to_i, 1].max
        cell_height = [((screen.height * 0.9) / y_size).to_i, 1].max
        cell_width = cell_height = [cell_width, cell_height].min

        box_x0 = (screen.width  - cell_width  * x_size) / 2
        box_x1 = screen.width - box_x0
        box_y0 = (screen.height - cell_height * y_size) / 2
        box_y1 = screen.height - box_y0

=begin
           if 2 < cell_width and 2 < cell_height
             (x_size + 1).times do |i|
              x = box_x0 + i * cell_width
              screen.render_line(x, box_y0, x, box_y1,
                                 Color.new(0xcc, 0xcc, 0xcc))
            end
             (y_size + 1).times do |j|
              y = box_y0 + j * cell_height
              screen.render_line(box_x0, y, box_x1, y,
                                 Color.new(0xcc, 0xcc, 0xcc))
            end
           end
=end
        
        if array[0][0].kind_of?(Numeric)
          # 2D
          array.each_with_index do |row, j|
            row.each_with_index do |cell, i|
              cell = [[cell, 0].max, 1].min
              x = box_x0 + i * cell_width
              y = box_y0 + j * cell_height
              width  = [cell_width, 1].max
              height = [cell_height, 1].max
              v = (cell * 255.0).to_i
              color = Color.new(v, v, v)
              screen.fill_rect(x, y, width, height, color)
            end
          end
        elsif array[0][0].kind_of?(Array)
          # 3D
          array.each_with_index do |row, j|
            row.each_with_index do |cell, i|
              cell = cell.map{|x| [[x, 0].max, 1].min}
              x = box_x0 + i * cell_width
              y = box_y0 + j * cell_height
              width  = [cell_width, 1].max
              height = [cell_height, 1].max
              r = ((cell[0] || 0) * 255.0).to_i
              g = ((cell[1] || 0) * 255.0).to_i
              b = ((cell[2] || 0) * 255.0).to_i
              color = Color.new(r, g, b)
              screen.fill_rect(x, y, width, height, color)
            end
          end
        end

      ensure
        render_texts(screen)
        render_player(screen)
        update_screen
      end
    end

  end
end
