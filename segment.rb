require './point'

class Segment
  attr_accessor :location

  def initialize(window, location, color=Gosu::Color::GREEN)
    @window = window
    @location = location
    @color = color
  end

  def draw
    @window.draw_quad(
      x, y, @color,
      x + 10, y, @color,
      x, y + 10, @color,
      x + 10, y + 10, @color)
  end

  def x
    @location.x
  end

  def y
    @location.y
  end

  def clone
    return Segment.new(@window, Point.new(x, y), @color)
  end

end