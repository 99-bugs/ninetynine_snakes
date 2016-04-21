class Snake

  def initialize(window, start_length=5, size=10)
    @segments = []
    @window = window
    @size = size

    for i in 0..start_length
      @segments << Segment.new(@window, Point.new(100, 100+i*@size))
    end

    # Counts down to lengthen the snake
    @segment_ticker = 0
  end

  def move(direction_vector)
    # Create new segment at the front
    new_segment = @segments.first.clone
    new_segment.location.translate_by_direction_vector(direction_vector.clone.enlarge(@size))
    @segments.unshift(new_segment)

    # Remove the last at the back
    if @segment_ticker == 0
      @segments.pop(1)
    else
      @segment_ticker -= 1
    end
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
