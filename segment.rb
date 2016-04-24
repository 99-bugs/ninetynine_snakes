require './game_object'
require './point'

class Segment < GameObject
  SPRITE_SIZE_FACTOR = 0.3
  SPRITE_SIZE = 96

  def initialize(window, location, color=Gosu::Color::GREEN)
    super(window, location, color)
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
  end

  def clone
    return Segment.new(@window, Point.new(x, y), @color)
  end

  def width
      @width
  end

  def height
      @height
  end

end
