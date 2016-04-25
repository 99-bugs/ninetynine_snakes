require './game_object'
require './point'

class Dot < GameObject
  SPRITE_SIZE_FACTOR = 0.1
  SPRITE_SIZE = 96

  MOTION_MAX_SPEED = 0.025
  MOTION_MAX_RADIUS = 10

  attr_accessor :center_location

  def initialize(window, location, color=Gosu::Color::RED)
    width = height = SPRITE_SIZE * SPRITE_SIZE_FACTOR
    super(window, location, width, height, 1.0, color)

    @window.texturemanager.load_texture('snake.png', 'dot', SPRITE_SIZE)

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
    @window.texturemanager.get_sprites('dot')[0].draw(
        x - (@width / 2),
        y - (@width / 2),
        1,
        @size * SPRITE_SIZE_FACTOR,
        @size * SPRITE_SIZE_FACTOR
    )
  end
end
