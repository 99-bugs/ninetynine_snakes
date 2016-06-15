class Bomb < Dot

  def initialize(window, location, width=nil, height=nil, sprite=nil, asset_key='bomb', grow_factor=-30)
    sprite = Sprite.new('fused_bomb.png', 0.2, 96, 96) unless sprite

    super

    @window.soundmanager.load_file('eat_bomb.wav', 'eat_bomb')
  end

  def destroy
    @window.soundmanager.play('eat_bomb')
  end

end
