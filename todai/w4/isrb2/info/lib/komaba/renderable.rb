require "starruby"

module Komaba
  module Renderable
    def on_rendered(texture)
    end
  end

end

class ::StarRuby::Texture
  def render(renderable)
    renderable.on_rendered(self)
  end
end
