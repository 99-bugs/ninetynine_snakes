class Segment < GameObject

  def initialize(window, location, width=nil, height=nil, sprite=nil, asset_key='segment')
    sprite = Sprite.new(window.configuration.snake_body_texture, 0.3, 96, 96) unless sprite
    super
  end

end
