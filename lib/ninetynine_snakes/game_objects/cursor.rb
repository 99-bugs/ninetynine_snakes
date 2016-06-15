class Cursor < GameObject

  def initialize(window, width=nil, height=nil, sprite=nil, asset_key='cursor')
    sprite = Sprite.new('target.png', 0.2, 211, 211) unless sprite
    location = Point.new(window.mouse_x, window.mouse_y)
    super(window, location, width, height, sprite, asset_key)
  end

  def update
    @location = Point.new(@window.mouse_x, @window.mouse_y)
  end
end