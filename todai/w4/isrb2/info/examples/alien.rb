require "komaba/mini_star"
include(Komaba::MiniStar)

# Try to create an instance of Rect.
# It will be shown on your screen.

class Rect < Sprite

 def display()
   render_rect(@x, @y, 100, 100, [1, 1, 1])
 end

end

# Definition of the class Woman

class Woman < Person

  def display()
    if !self.is_visible()
      return
    end
    super()
    render_filled_trapezoid(@x - 5, @y - @height / 2, 10, 20, @height / 3, @color)
  end

end

# Definition of the class Child

class Child < Person
  
  def initialize()
    super()
    self.height = 50
  end
  
  def height=(v)
    if 100 < v
      v = 100
    end
    super(v)
  end
  
end

# Definition of the class Alien
# Note that x= and y= do not invoke redisplay_all_objects.

class Alien < Person

  def initialize()
    @r = 200
    @theta = Math::PI / 4
    super
  end
  
  def x()
    @r * Math.cos(@theta)
  end

  def x=(x)
    self.set_xy(x, self.y)
  end

  def y()
    @r * Math.sin(@theta)
  end

  def y=(y)
    self.set_xy(self.x, y)
  end

  def set_xy(x, y)
    @r = Math.sqrt(x ** 2 + y ** 2)
    @theta = Math.atan2(y, x)
    redisplay_all_objects()
  end

end

# Arrange 16 persons and aliens randomly mixed.

def person16()
  a = Array.new(16)
  for i in 0..15
    if rand(2) == 0
      a[i] = Person.new()
    else
      a[i] = Alien.new()
    end
    a[i].x = rand(300) + 100
    a[i].y = rand(300) + 100
    a[i].height = rand(60) + 40
  end
  a
end
