require 'ninetynine_snakes/2d/point'

class GameObject
  attr_accessor :location, :width, :height

  def initialize(window, location, width, height, color=Gosu::Color::RED)
    @window = window
    @location = location
    @color = color
    @width = width
    @height = height
  end

  # sprite_params = {
  #     file: 'filename.png',
  #     key: 'dot',
  #     size_factor: 1.0,
  #     width: 32,
  #     height: 48
  # }
  def set_sprite(sprite_params={})
    @sprite_params = sprite_params
    if (!(@sprite_params.nil? || @sprite_params.empty?))
      @window.texturemanager.load_texture(@sprite_params[:file], @sprite_params[:key],
        @sprite_params[:width], @sprite_params[:height])
    end
  end

  def draw
    if (!(@sprite_params.nil? || @sprite_params.empty?))
      @window.texturemanager.get_sprites(@sprite_params[:key])[0].draw(
          x - (@width / 2),
          y - (@height / 2),
          1,
          @sprite_params[:size_factor],
          @sprite_params[:size_factor]
      )
    else
      @window.draw_quad(
        x, y, @color,
        x + @width, y, @color,
        x, y + @height, @color,
        x + @width, y + @height, @color)
    end
  end

  def x
    @location.x
  end

  def y
    @location.y
  end
end
