require './point'

class Segment
  attr_accessor :location
  SPRITE_SIZE_FACTOR = 0.3
  SPRITE_SIZE = 96

  def initialize(window, location, color=Gosu::Color::GREEN)
    @window = window
    @location = location
    @color = color
    @size = 1.0;
    @width = @height = SPRITE_SIZE * SPRITE_SIZE_FACTOR
    @sprites = Gosu::Image::load_tiles('./textures/snake.png', SPRITE_SIZE, SPRITE_SIZE)
  end

  def draw
    @sprites[0].draw(
        x - (@width / 2),
        y - (@width / 2),
        1,
        @size * SPRITE_SIZE_FACTOR,
        @size * SPRITE_SIZE_FACTOR
    )
    # @window.draw_quad(
    #   x, y, @color,
    #   x + 10, y, @color,
    #   x, y + 10, @color,
    #   x + 10, y + 10, @color)
  end

  def x
    @location.x
  end

  def y
    @location.y
  end

end
