# Points represents a 2D location on our playfield

class Point
  attr_accessor :x, :y

  def initialize(x = 0.0, y = 0.0)
    @x = x
    @y = y
  end

  # Direction vector does not have to be unity vector (it can have a certain length)
  # Origin is not taken into account
  def translate_by_direction_vector(dir_vector)
    @x = @x + dir_vector.head.x
    @y = @y + dir_vector.head.y
  end
end
