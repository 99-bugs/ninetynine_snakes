class GameObject
  attr_accessor :location, :width, :height, :size

  def initialize(window, location, width, height, size=1.0, color=Gosu::Color::RED)
    @window = window
    @location = location
    @color = color
    @width = width
    @height = height
    @size = size
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
end
