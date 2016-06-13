require 'ninetynine_snakes/2d/vector'

class Snake

  attr_reader :segment_diameter, :length
  attr_accessor :id

  def initialize(game, start_length=5, segment_diameter=10)
    @segments = []
    @game = game
    @segment_diameter = segment_diameter
    @speed = 0.2
    @turn_radius = 30
    @length = 1.0*start_length

    start_length.times do |i|
      @segments << Segment.new(@game, Point.new(100, 100+i*@segment_diameter))
    end
    @prev_angle = 0

    @gravity = {
        force: 10,
        distance: 2.5 * head.width / 2  #note: head.width => sprite width !
    }
  end

  def update(direction_vector)

      @game.server.update self

      delta_angle = direction_vector.angle - @prev_angle
      delta_angle += Math::PI * 2 while delta_angle < Math::PI
      delta_angle -= Math::PI * 2 while delta_angle > Math::PI
      angle = @prev_angle + delta_angle / @turn_radius

      move_head angle

      @prev_angle = angle
  end

  def update_head_position x, y
      head.location.x = x
      head.location.y = y

      move_body

      suck_in_nearby_food
      eat_closeby_food
  end

  def move_head(angle)
      dx = Math.cos(angle) * @segment_diameter * @speed
      dy = Math.sin(angle) * @segment_diameter * @speed
      x = head.location.x + dx
      y = head.location.y + dy

      update_head_position x, y
  end

  def move_body
      head = @segments.first
      (1..@segments.size-1).each do |i|
          destination = Vector.new(@segments[i].location, head).to_unity.enlarge(@segment_diameter)
          @segments[i].location = destination.head
          head = @segments[i]
      end
  end

  def number_of_segments
    @segments.length
  end

  def draw
    # Draw segments tail to head (head on top)
    @segments.reverse.each do |s|
      s.draw
    end
  end

  def head
    @segments.first
  end

  def grow(length=0.0)
    @length += length

    # Yes, your snake can die !
    raise "You are dead" unless @length > 0

    if (@length.floor > number_of_segments)
      (@length.floor - number_of_segments).times do |i|
        @segments << Segment.new(@game, Point.new(0,0))
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

  def suck_in_nearby_food
    snake = @game.universe.player
    @game.universe.food.get_nearby_food(location, @gravity[:distance]).each do |food|
        distance = Gosu::distance(snake.x, snake.y, food.x, food.y)
        distance_factor = 1 - (distance / @gravity[:distance])
        if distance < @gravity[:distance]
            dx = snake.x - food.x
            dy = snake.y - food.y
            dx = dx / @gravity[:force] * distance_factor
            dy = dy / @gravity[:force] * distance_factor
            food.center_location.x += dx
            food.center_location.y += dy
        end
    end
  end

  def eat_closeby_food
    distance = head.width / 2
    @game.universe.food.get_nearby_food(location, distance).each do |food|
      grow(1.0 * food.grow_factor / number_of_segments)
      @game.universe.food.destroy food
    end
  end

  def score
    @length
  end
end
