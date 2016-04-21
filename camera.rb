class Camera
  attr_accessor :location

  def initialize(viewport_width, viewport_height)
    @viewport_width = viewport_width
    @viewport_height = viewport_height
  end

  def tick(ref_point)
    x = -ref_point.x + @viewport_width/2
    y = -ref_point.y + @viewport_height/2
    @location = Point.new(x, y)
  end

  def x
    @location.x
  end

  def y
    @location.y
  end

end