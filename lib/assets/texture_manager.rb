class TextureManager
  TEXTURE_DIR = "./textures/"

  def initialize(window)
    @assets = Hash.new
    @window = window
  end

  def load_image(file, key)
    if (!@assets.has_key?(key))
      @assets[key] = Gosu::Image.new(@window, TEXTURE_DIR + file, true)
    else
      raise "Image already loaded - " + file
    end
  end

  def load_texture(file, key, sprite_width, sprite_height)
    @assets[key] = Gosu::Image::load_tiles(TEXTURE_DIR + file, sprite_width, sprite_height)
  end

  def get_image(key)
    if (@assets.has_key?(key))
      return @assets[key]
    else
      raise "Image not found - " + file
    end
  end

  def get_sprites(key)
    if (@assets.has_key?(key))
      return @assets[key]
    else
      raise "Sprites not found - " + file
    end
  end
end