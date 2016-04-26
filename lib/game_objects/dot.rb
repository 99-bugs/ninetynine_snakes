require File.expand_path("../game_object", __FILE__)

class Dot < GameObject
  MOTION_MAX_SPEED = 0.025
  MOTION_MAX_RADIUS = 10

  attr_accessor :center_location

  def initialize(window, location, color=Gosu::Color::RED)

    sprite_params = {
      file: 'snake.png',
      key: 'dot',
      size_factor: 0.1,
      width: 96,
      height: 96
    }
    width = height = sprite_params[:width] * sprite_params[:size_factor]

    super(window, location, width, height, sprite_params, color)
    @center_location = location.clone
    generate_motion
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
      location.x = @center_location.x + Math.cos(@motion[:angle]) * @motion[:radius]
      location.y = @center_location.y + Math.sin(@motion[:angle]) * @motion[:radius]
  end
end
