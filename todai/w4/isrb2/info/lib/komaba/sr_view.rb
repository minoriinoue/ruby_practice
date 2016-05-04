require "thread"
require "starruby"

module Komaba
  class SRView

    include StarRuby

    attr_reader :game

    def initialize(width, height, options)
      @game = Game.new(width, height, {:cursor => true}.merge(options))
      images_dir = File.join(File.dirname(__FILE__), "./images")
      @textures = {
        :start => Texture.load(File.join(images_dir, "media-playback-start.png")),
        :stop  => Texture.load(File.join(images_dir, "media-playback-stop.png")),
        # :pause => Texture.load(File.join(images_dir, "media-playback-pause.png")),
        :plus  => Texture.load(File.join(images_dir, "list-add.png")),
        :minus => Texture.load(File.join(images_dir, "list-remove.png")),
        :none  => Texture.new(32, 32)
      }
      @state = :init
      @frames = 0
      @speed = 3
      @checkpoint_state = :go
      @checkpoint_flag = false
    end

    def dispose
      @game.dispose unless @game.disposed?
    end

    def disposed?
      @game.disposed?
    end

    def check_disposing
      unless @game.disposed?
        @game.update_state
        if Input.keys(:keyboard).include?(:escape) or @game.window_closing?
          @game.dispose
        end
      end
    end

    def wait
      @game.wait unless @game.disposed?
    end

    def update_screen
      @game.update_screen unless @game.disposed?
    end

    def add_object(obj)
      queue << obj
    end

    def add_text(text, x, y)
      texts << [text, x, y]
    end

    def checkpoint
      @checkpoint_flag = true
    end

    protected

    attr_reader :state
    attr_reader :frames

    def queue
      @queue ||= Queue.new
    end

    def texts
      @texts ||= []
    end

    def update
      if @checkpoint_flag and @checkpoint_state == :stop
        @checkpoint_state = :stop2
        $stdout.puts("stop at the checkpoint! " +
                     "(press the space key or the enter key to restart)")
        $stdout.flush
        @checkpoint_flag = false
      end
      if @checkpoint_state == :stop2
        upf = UPDATING_PER_FRAME[@speed]
        @frames = ((@frames - 1) / upf + 1) * upf
      else
        @frames += 1
      end
      # update_player
      x, y = Input.mouse_location
      if Input.keys(:mouse, :duration => 1).include?(:left)
        if 0 <= y and y < 32
          if 0 <= x and x < 32
            @state = :playing if @state != :playing
          elsif 40 <= x and x < 40 + 32
            @speed = [@speed - 1, 1].max
          elsif 40 + 32 <= x and x < 40 + 64
            @speed = [@speed + 1, 4].min
          end
        end
      end
      keys = Input.keys(:keyboard, :duration => 1)
      if keys.include?(:space)
        @checkpoint_state = :stop
      elsif keys.include?(:enter)
        @checkpoint_state = :go
      end
    end

    def render_player(screen)
      image = case @state
              when :playing;      :none
              when :pause, :init; :start
              end
      screen.render_texture(@textures[image], 0, 0)
      screen.render_texture(@textures[:minus], 40, 0)
      screen.render_texture(@textures[:plus], 40 + 32, 0)
      font = fonts[20]
      speed_text = case @speed
                   when 1; "Very Slow"
                   when 2; "Slow"
                   when 3; "Fast"
                   when 4; "Very Fast"
                   end
      text = "Speed: #{speed_text}"
      width, height = font.get_size(text)
      screen.render_text(text, 40 + 64 + 8, (32 - height) / 2, font,
                         Color.new(0xff, 0xff, 0xff), true)
    end

    def render_texts(screen)
      font = fonts[20]
      texts.each do |text, x, y|
        screen.render_text(text, x, y, font, Color.new(0xff, 0xff, 0xff), true)
      end
    end

    def fonts
      @fonts ||= (Hash.new do |hash, size|
                    hash[size] = Font.new(font_name, size)
                  end)
    end

    def font_name
      @font_name ||= ["/System/Library/Fonts/Thonburi.ttf",
                      "Arial",
                      "Bitstream Vera Sans, Roman",
                      "FreeSans,Medium"].each do |font_name|
        if Font.exist?(font_name)
          return font_name
        end
      end
    end

    UPDATING_PER_FRAME = {
      1 => 40,
      2 => 16,
      3 => 4,
      4 => 1,
    }.freeze

    def time_to_update?
      return false if @checkpoint_state == :stop2
      return @frames % UPDATING_PER_FRAME[@speed] == 0
    end

    def end_init
      @state = :pause if @state == :init
    end

  end
end
