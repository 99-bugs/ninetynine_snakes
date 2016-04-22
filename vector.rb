class Vector

  attr_accessor :head, :origin

  def initialize(head, origin)
    @origin = origin
    @head = head
  end

  def length
    Math.sqrt((@head.x - @origin.x)*(@head.x - @origin.x) + (@head.y - @origin.y)*(@head.y - @origin.y))
  end

  # Return a new unity vector of the current vector
  def to_unity(keep_origin=true)
    head_x = (@head.x - @origin.x)/length
    head_y = (@head.y - @origin.y)/length
    head_x += @origin.x if keep_origin
    head_y += @origin.y if keep_origin

    return Vector.new(Point.new(head_x, head_y), @origin)
  end

  def enlarge(factor)
    @head.x = @origin.x + (@head.x - @origin.x)*factor
    @head.y = @origin.y + (@head.y - @origin.y)*factor
    return self
  end

  def flip
    @head.x = -@head.x
    @head.y = -@head.y
    return self
  end

  def to_discrete
    return Vector.new(Point.new(@head.x.round, @head.y.round), Point.new(@origin.x.round, @origin.y.round))
  end

  def clone
    return Vector.new(Point.new(@head.x, @head.y), Point.new(@origin.x, @origin.y))
  end

  # Return a unitized directional vector which has its origin set to (0,0)
  def to_direction
    return Vector.new(to_unity(false).head, Point.new(0, 0))
  end

  def to_s
    return "[#{@origin.x},#{@origin.y}] ==> [#{@head.x},#{@head.y}] (lenght = #{length})"
  end

  def angle
      dx = head.x - origin.x
      dy = head.y - origin.y
      Math.atan2(dy,dx)
    end
end
