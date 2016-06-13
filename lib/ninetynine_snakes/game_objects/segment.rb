require 'ninetynine_snakes/game_objects/game_object'

class Segment < GameObject

  def initialize(window, location, width=nil, height=nil, color=Gosu::Color::GREEN)

    sprite_params = default_sprite if sprite_params.nil?
    width = sprite_params[:width] * sprite_params[:size_factor] if width.nil?
    height = sprite_params[:height] * sprite_params[:size_factor] if height.nil?

    super(window, location, width, height, color)
    set_sprite(sprite_params)
  end

  def default_sprite
    sprite_params = {
      file: 'snake.png',
      key: 'segment',
      size_factor: 0.3,
      width: 96,
      height: 96
    }
  end

  def clone
    return Segment.new(@window, Point.new(x, y), @color)
  end

end
