class Snake
    MAX_ANGLE = 10.0 / 60

  def initialize(window, start_length=5, size=10)
    @segments = []
    @window = window
    @size = size
    @speed = 5

    start_length.times do |i|
      @segments << Segment.new(@window, Point.new(100, 100+i*@size))
    end
    @prev_angle = 0

  end

  def move(direction_vector)
      delta_angle = direction_vector.angle - @prev_angle
      delta_angle += Math::PI * 2 while delta_angle < Math::PI
      delta_angle -= Math::PI * 2 while delta_angle > Math::PI
      angle = @prev_angle + delta_angle / 30

      move_head angle
      move_body
      @prev_angle = angle
  end

  def move_head(angle)
      dx = Math.cos(angle) * @size / @speed
      dy = Math.sin(angle) * @size / @speed
      @segments.first.location.x += dx
      @segments.first.location.y += dy
  end

  def move_body
      head = @segments.first
      (1..@segments.size-1).each do |i|
          destination = Vector.new(@segments[i].location, head).to_unity.enlarge(@size)
          @segments[i].location = destination.head
          head = @segments[i]
      end
      #exit
  end

  # Returns length of snake
  def length
    @segments.length
  end

  def draw
    # Draw the segments
    @segments.reverse.each do |s|
      s.draw
    end
  end

  def head
    return @segments.first
  end

  def grow(number_of_segments)
    @segment_ticker = number_of_segments
  end

  def x
      head.x
  end

  def y
      head.y
  end

  def location
      head.location
  end

end
