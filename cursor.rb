require './game_object'
require './point'

class Cursor < GameObject
  SPRITE_SIZE_FACTOR = 0.2
  SPRITE_SIZE = 211

  def initialize(window)
    super(window, Point.new(window.mouse_x, window.mouse_y), nil)
    @size = 1.0;
    @width = @height = SPRITE_SIZE * SPRITE_SIZE_FACTOR
    @sprites = Gosu::Image::load_tiles('./textures/target.png', SPRITE_SIZE, SPRITE_SIZE)
  end

  def update_position
    @location = Point.new(@window.mouse_x, @window.mouse_y)
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
