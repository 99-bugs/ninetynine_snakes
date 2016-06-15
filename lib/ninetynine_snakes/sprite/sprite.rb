class Sprite

  attr_reader :file,
              :size_factor,
              :width,
              :height

  def initialize (file, size_factor, width, height)
    @file = file
    @size_factor = size_factor
    @width = width
    @height = height
  end

end