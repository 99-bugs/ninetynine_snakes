require './game_object'
require './lib/2d/point'

class Segment < GameObject

  def initialize(window, location, color=Gosu::Color::GREEN)

    sprite_params = {
      file: 'snake.png',
      key: 'segment',
      size_factor: 0.3,
      width: 96,
      height: 96
    }
    width = height = sprite_params[:width] * sprite_params[:size_factor]

    super(window, location, width, height, sprite_params, color)
  end

  def clone
    return Segment.new(@window, Point.new(x, y), @color)
  end

end
