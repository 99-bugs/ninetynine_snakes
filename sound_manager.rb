class SoundManager
  SOUND_DIR = "./sounds/"

  def initialize()
    @sounds = Hash.new
  end

  def load_file(file, key)
    if (!@sounds.has_key?(key))
      @sounds[key] = Gosu::Sample.new(SOUND_DIR + file)
    else
      raise "Sound already loaded - " + file
    end
  end

  def play(key)
    if (@sounds.has_key?(key))
      @sounds[key].play()
    else
      raise "No such sound found - " + key
    end
  end
end