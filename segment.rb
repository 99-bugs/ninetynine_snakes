require './point'

class Segment
  attr_accessor :location

  # Should be:
  # def initialize(window, x, y, color=Gosu::Color::GREEN)
  def initialize(snake, window, position, color=Gosu::Color::GREEN)
    @window = window
    @location = Point.new(position[0], position[1])
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