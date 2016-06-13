class SoundManager
  SOUND_DIR = "assets/sounds/"

  def initialize()
    @assets = Hash.new
  end

  def load_file(file, key)
    @assets[key] = Gosu::Sample.new(SOUND_DIR + file)
  end

  def play(key)
    if (@assets.has_key?(key))
      @assets[key].play()
    else
      raise "No such sound found - " + key
    end
  end
end