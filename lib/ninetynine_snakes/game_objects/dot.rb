class Dot < GameObject

  MOTION_MAX_SPEED = 0.025
  MOTION_MAX_RADIUS = 10

  attr_accessor :center_location
  attr_reader :grow_factor

  def initialize(window, location, width=nil, height=nil, sprite=nil, asset_key='dot', grow_factor=10)
    sprite = Sprite.new('dot.png', 0.1, 96, 96) unless sprite

    super(window, location, width, height, sprite, asset_key)

    @center_location = location.clone
    generate_motion
    @grow_factor = grow_factor

    @window.soundmanager.load_file('eat_dot.wav', 'eat_dot')
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

  def destroy
    @window.soundmanager.play('eat_dot')
  end

end
