require "starruby"
require "komaba/mini_star/bitmap"
require "komaba/mini_star/person"
require "komaba/mini_star/sprite"

module Komaba
  module MiniStar

    include StarRuby

    module_function

    @@actions = []
    @@show_classes = false
    @@checkpoint_flag = :go

    def start
      unless updatable?
        @@game = Game.new(640, 480, :title => "Ruby", :cursor => true)
      end
    end

    def show_classes
      @@show_classes = true
      update
    end

    def hide_classes
      @@show_classes = false
      update
    end

    def classes_visible?
      @@show_classes
    end

    def updatable?
      !!Game.current
    end

    def update
      return unless updatable?
      update_internal
      keys = Input.keys(:keyboard)
      if keys.include?(:space)
        @@checkpoint_flag = :stop
      elsif keys.include?(:enter)
        @@checkpoint_flag = :go
      end
    end

    def screen
      if Game.current
        @screen ||= Bitmap.new(Game.current.screen)
      else
        nil
      end
    end

    def halt
      loop{update}
    end

    def checkpoint
      if @@checkpoint_flag == :stop
        puts "stop at the checkpoint! (press the space key or the enter key to restart)"
        loop do
          update
          keys = Input.keys(:keyboard)
          break if keys.include?(:space) or keys.include?(:enter)
        end
      end
    end

    def redisplay_all_objects
      MiniStar.update if MiniStar.updatable?
    end

    def is_pressed(key)
      key = key.intern if key.kind_of?(String)
      Input.keys(:keyboard).include?(key)
    end

    private

    def update_internal
      exit if !Game.current or Game.current.disposed?
      Game.current.update_state
      exit if Input.keys(:keyboard).include?(:escape) or Game.current.window_closing?
      screen.texture.fill(Color.new(0, 0, 0))
      @@sprites_texture ||= Texture.new(640, 480)
      @@sprites_bitmap ||= Bitmap.new(@@sprites_texture)
      @@sprites_texture.clear
      begin
        AbstractSprite.rendering = true
        Sprite.each do |sprite|
          @@sprites_bitmap.render_sprite(sprite)
        end
      ensure
        AbstractSprite.rendering = false
      end
      @@classes_texture ||= Texture.new(320, 480)
      @@classes_bitmap ||= Bitmap.new(@@classes_texture)
      @@classes_texture.clear
      render_sprite_classes_tree(@@classes_bitmap, sprite_classes_tree, 0, 0)
      if @@show_classes
        screen.texture.render_texture(@@classes_texture, 0, 0)
        screen.texture.render_texture(@@sprites_texture, 320, 0)
      else
        screen.texture.render_texture(@@sprites_texture, 0, 0)
      end
      Game.current.update_screen
      Game.current.wait
    end

    def sprite_classes
      Object.constants.map do |c|
        Object.const_get(c)
      end.select do |c|
        c.kind_of?(Class) and c.ancestors.include?(Sprite)
      end
    end

    def sprite_classes_tree
      tree = [Sprite]
      def create_node(node, classes)
        children = classes.select{|c| c.superclass == node[0]}.sort do |a, b|
          a.name <=> b.name
        end
        children.each do |c|
          child_node = [c]
          create_node(child_node, classes - [c])
          node << child_node
        end
      end
      create_node(tree, sprite_classes - [Sprite])
      tree
    end

    def render_sprite_classes_tree(bitmap, tree, x, y, width = bitmap.width)
      methods = tree[0].methods_to_show
      rect_width = [width, 320].min
      rect_height = methods.size * 10 + 32
      rect_x = x + (width - rect_width) / 2
      rect_y = y
      bitmap.texture.render_rect(rect_x, rect_y,
                                 rect_width, rect_height,
                                 Color.new(0xcc, 0xcc, 0xcc))
      line_color = Color.new(0x99, 0x99, 0x99)
      bitmap.texture.render_line(rect_x, rect_y,
                                 rect_x + rect_width - 1, rect_y,
                                 line_color)
      bitmap.texture.render_line(rect_x,                  rect_y + rect_height - 1,
                                 rect_x + rect_width - 1, rect_y + rect_height - 1,
                                 line_color)
      bitmap.texture.render_line(rect_x, rect_y,
                                 rect_x, rect_y + rect_height - 1,
                                 line_color)
      bitmap.texture.render_line(rect_x + rect_width - 1, rect_y,
                                 rect_x + rect_width - 1, rect_y + rect_height - 1,
                                 line_color)
      bitmap.render_text(tree[0].name[/[^:]+$/], rect_x + 8, rect_y + 8, 12, [0, 0, 0])
      methods.map{|s| s.to_s}.sort.each_with_index do |m, i|
        if tree[0].calling_method == m.intern
          color = [1, 0, 0]
        else
          color = [0, 0, 0]
        end
        bitmap.render_text(m, rect_x + 8, rect_y + 22 + i * 10, 10, color)
      end
      children = tree[1..-1]
      children.each_with_index do |child, i|
        render_sprite_classes_tree(bitmap, child,
                                   x + i * (width / children.size), y + rect_height + 10,
                                   width / children.size)
      end
    end

  end
end
