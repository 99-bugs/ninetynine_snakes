class Sprite

  attr_reader :relative_path,
              :size_factor,
              :width,
              :height

  def initialize (relative_path, size_factor, width, height)
    @relative_path = relative_path
    @size_factor = size_factor
    @width = width
    @height = height
  end

end