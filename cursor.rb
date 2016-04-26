require './game_object'
require './lib/2d/point'

class Cursor < GameObject
  SPRITE_SIZE_FACTOR = 0.2
  SPRITE_SIZE = 211

  def initialize(window)

    sprite_params = {
      file: 'target.png',
      key: 'cursor',
      size_factor: 0.2,
      width: 211,
      height: 211
    }
    width = height = sprite_params[:width] * sprite_params[:size_factor]
    location = Point.new(window.mouse_x, window.mouse_y)

    super(window, location, width, height, sprite_params)
  end

  def update_position
    @location = Point.new(@window.mouse_x, @window.mouse_y)
  end

end
