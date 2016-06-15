class GameObject
  attr_accessor :location
  attr_reader :width,
              :height

  def initialize(window, location, width=nil, height=nil, sprite=nil, asset_key=nil)
    @window = window
    @location = location
    @sprite = sprite
    @asset_key = asset_key

    @width = @sprite.width * @sprite.size_factor unless width
    @height = @sprite.height * @sprite.size_factor unless height

    load_asset
  end

  def draw
    if @sprite
      @window.spritemanager.get_sprites(@asset_key)[0].draw(
          x - (@width / 2),
          y - (@height / 2),
          1,
          @sprite.size_factor,
          @sprite.size_factor
      )
    else
      color = Gosu::Color::RED
      @window.draw_quad(
        x, y, color,
        x + @width, y, color,
        x, y + @height, color,
        x + @width, y + @height, color)
    end
  end

  def x
    @location.x
  end

  def y
    @location.y
  end

  private
  def load_asset
    @window.spritemanager.load_sprites(@sprite, @asset_key) if @asset_key
  end
end