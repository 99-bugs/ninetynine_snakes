require File.expand_path("../dot", __FILE__)

class Bomb < Dot

  def initialize(window, location, width=nil, height=nil, sprite_params=nil, grow_factor=-30, color=Gosu::Color::RED)

    sprite_params = default_sprite if sprite_params.nil?
    width = sprite_params[:width] * sprite_params[:size_factor] if width.nil?
    height = sprite_params[:height] * sprite_params[:size_factor] if height.nil?

    super(window, location, width, height, sprite_params, grow_factor, color)

    @window.soundmanager.load_file('eat_bomb.wav', 'eat_bomb')
  end

  def default_sprite
    sprite_params = {
      file: 'fused_bomb.png',
      key: 'bomb',
      size_factor: 0.2,
      width: 96,
      height: 96
    }
  end

  def destroy
    @window.soundmanager.play('eat_bomb')
  end
end
