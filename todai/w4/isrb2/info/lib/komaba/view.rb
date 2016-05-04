require "thread"
require "komaba/sr_view"
require "komaba/object_renderer"

module Komaba

  class View < SRView

    def initialize
      super(640, 480, :title => "Ruby")
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
        obj = @current_object
        screen.render(ObjectRenderer.new(obj, 64, 80, fonts[12]))
      ensure
        render_texts(screen)
        render_player(screen)
        update_screen
      end
    end

  end
end
