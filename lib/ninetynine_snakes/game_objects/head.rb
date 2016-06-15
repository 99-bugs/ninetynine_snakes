class Head < Segment

  def initialize(window, location, width=nil, height=nil, sprite=nil, asset_key='head')
    sprite = Sprite.new(window.configuration.snake_head_texture, 0.3, 96, 96) unless sprite
    super
  end

end
