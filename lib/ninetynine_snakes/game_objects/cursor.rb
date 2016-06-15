class Cursor < GameObject
  SPRITE_SIZE_FACTOR = 0.2
  SPRITE_SIZE = 211

  def initialize(window, width=nil, height=nil, sprite_params=nil)

    sprite_params = default_sprite if sprite_params.nil?
    width = sprite_params[:width] * sprite_params[:size_factor] if width.nil?
    height = sprite_params[:height] * sprite_params[:size_factor] if height.nil?
    location = Point.new(window.mouse_x, window.mouse_y)

    super(window, location, width, height)
    set_sprite(sprite_params)
  end

  def default_sprite
    sprite_params = {
      file: 'target.png',
      key: 'cursor',
      size_factor: 0.2,
      width: 211,
      height: 211
    }
  end

  def update
    @location = Point.new(@window.mouse_x, @window.mouse_y)
  end

end
