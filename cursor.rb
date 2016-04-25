require './game_object'
require './lib/2d/point'

class Cursor < GameObject
  SPRITE_SIZE_FACTOR = 0.2
  SPRITE_SIZE = 211

  def initialize(window)
    width = height = SPRITE_SIZE * SPRITE_SIZE_FACTOR
    super(window, Point.new(window.mouse_x, window.mouse_y), width, height, 1.0, nil)

    @window.texturemanager.load_texture('target.png', 'cursor', SPRITE_SIZE)
  end

  def update_position
    @location = Point.new(@window.mouse_x, @window.mouse_y)
  end

  def draw
    @window.texturemanager.get_sprites('cursor')[0].draw(
        x - (@width / 2),
        y - (@width / 2),
        1,
        @size * SPRITE_SIZE_FACTOR,
        @size * SPRITE_SIZE_FACTOR
    )
  end

end
