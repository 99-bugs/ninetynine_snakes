require './game_object'
require './point'

class Dot < GameObject
  SPRITE_SIZE_FACTOR = 0.1
  SPRITE_SIZE = 96

  def initialize(window, location, color=Gosu::Color::RED)
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
end