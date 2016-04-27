require File.expand_path("../game_object", __FILE__)

class Dot < GameObject
  MOTION_MAX_SPEED = 0.025
  MOTION_MAX_RADIUS = 10

  attr_accessor :center_location
  attr_reader :grow_factor

  def initialize(window, location, width=nil, height=nil, sprite_params=nil, grow_factor=10, color=Gosu::Color::RED)

    sprite_params = default_sprite if sprite_params.nil?
    width = sprite_params[:width] * sprite_params[:size_factor] if width.nil?
    height = sprite_params[:height] * sprite_params[:size_factor] if height.nil?

    super(window, location, width, height, color)
    set_sprite(sprite_params)

    @center_location = location.clone
    generate_motion
    @grow_factor = grow_factor
  end

  def default_sprite
    sprite_params = {
      file: 'snake.png',
      key: 'dot',
      size_factor: 0.1,
      width: 96,
      height: 96
    }
  end

  def generate_motion
    r = Random.new
    @motion = {
        speed: r.rand(-MOTION_MAX_SPEED..MOTION_MAX_SPEED),
        radius: r.rand(0..MOTION_MAX_RADIUS),
        angle: r.rand(-Math::PI..Math::PI)
    }
  end

  def update
      @motion[:angle] += @motion[:speed]
      @location.x = @center_location.x + Math.cos(@motion[:angle]) * @motion[:radius]
      @location.y = @center_location.y + Math.sin(@motion[:angle]) * @motion[:radius]
  end
end
