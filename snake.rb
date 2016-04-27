require './lib/2d/vector'

class Snake

  attr_accessor :size   # Diameter of segments
  attr_reader :length
  attr_accessor :score

  def initialize(window, start_length=5, size=10)
    @segments = []
    @window = window
    @size = size
    @speed = 5
    @turn_radius = 30
    @length = 1.0*start_length
    @score = 0.0

    start_length.times do |i|
      @segments << Segment.new(@window, Point.new(100, 100+i*@size))
    end
    @prev_angle = 0
  end

  def move(direction_vector)
      delta_angle = direction_vector.angle - @prev_angle
      delta_angle += Math::PI * 2 while delta_angle < Math::PI
      delta_angle -= Math::PI * 2 while delta_angle > Math::PI
      angle = @prev_angle + delta_angle / @turn_radius

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
  end

  def number_of_segments
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

  def grow(length=0.0)
    @length += length

    # Yes, your snake can die !
    raise "You are dead" unless @length > 0

    if (@length.floor > number_of_segments)
      (@length.floor - number_of_segments).times do |i|
        @segments << Segment.new(@window, Point.new(0,0))
      end
    elsif (@length.floor < number_of_segments)
      @segments.pop(number_of_segments - @length.floor)
    end
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
