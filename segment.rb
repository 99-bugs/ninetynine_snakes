require './game_object'
require './point'

class Segment < GameObject
  SPRITE_SIZE_FACTOR = 0.3
  SPRITE_SIZE = 96

  def initialize(window, location, color=Gosu::Color::GREEN)
    width = height = SPRITE_SIZE * SPRITE_SIZE_FACTOR
    super(window, location, width, height, 1.0, color)

    @window.texturemanager.load_texture('snake.png', 'segment', SPRITE_SIZE)
  end

  def draw
    @window.texturemanager.get_sprites('segment')[0].draw(
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
