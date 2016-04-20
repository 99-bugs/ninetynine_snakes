require './point'

class Apple
  attr_accessor :location

  # Should be:
  # def initialize(window, x, y, color=Gosu::Color::RED)
  def initialize(window, color=Gosu::Color::RED)
    @window = window
    # Must be 50 to make sure it doesn't overlap the score
    @location = Point.new(rand(10..630), rand(50..470)) 
    # Should be:
    # @location = Point.new(x, y)
    @color = color
  end

  def draw
    @window.draw_quad(@location.x, @location.y, @color,
      @location.x + 10, @location.y, @color,
      @location.x, @location.y + 10, @color,
      @location.x + 10, @location.y + 10, @color)
  end

  def xpos
    @location.x
  end

  def ypos
    @location.y
  end

end