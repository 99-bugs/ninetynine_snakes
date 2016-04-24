require './game_object'
require './point'

class Dot < GameObject
  SPRITE_SIZE_FACTOR = 0.1
  SPRITE_SIZE = 96

  MOTION_MAX_SPEED = 0.025
  MOTION_MAX_RADIUS = 10

  attr_accessor :center_location

  def initialize(window, location, color=Gosu::Color::RED)
    super(window, location, color)
    @size = 1.0;
    @width = @height = SPRITE_SIZE * SPRITE_SIZE_FACTOR
    @sprites = Gosu::Image::load_tiles('./textures/snake.png', SPRITE_SIZE, SPRITE_SIZE)
    r = Random.new
    @motion = {
        speed: r.rand(-MOTION_MAX_SPEED..MOTION_MAX_SPEED),
        radius: r.rand(0..MOTION_MAX_RADIUS),
        angle: r.rand(-Math::PI..Math::PI)
    }
    @center_location = location.clone
  end

  def update
      @motion[:angle] += @motion[:speed]
      location.x = @center_location.x + Math.cos(@motion[:angle]) * @motion[:radius]
      location.y = @center_location.y + Math.sin(@motion[:angle]) * @motion[:radius]
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
