class SpritesNotFound < Exception; end

class SpriteManager
  SPRITE_DIR = "assets/sprites/"

  def initialize(window)
    @assets = Hash.new
    @window = window
  end

  def load_sprites(sprite, key)
    @assets[key] = Gosu::Image::load_tiles(SPRITE_DIR + sprite.relative_path, sprite.width, sprite.height)
  end

  def get_sprites(key)
    if (@assets.has_key?(key))
      return @assets[key]
    else
      raise SpritesNotFound.new("Sprites not found - " + key)
    end
  end
end