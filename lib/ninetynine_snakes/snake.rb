require 'ninetynine_snakes/2d/vector'

class Snake

  attr_reader :length
  attr_accessor :id

  def initialize(game, start_length=5, segment_diameter=10)
    @segments = []
    @game = game
    @segment_diameter = segment_diameter
    @speed = 0.2
    @turn_radius = 30
    self.length = 1.0*start_length
    @prev_angle = 0

    @gravity = {
        force: 10,
        distance: 2.5 * head.width / 2  #note: head.width => sprite width !
    }

  end

  def update(direction_vector)

      @game.server.update self if @game.server

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
      target_segment = @segments.first
      (1..number_of_segments-1).each do |i|
          destination = Vector.new(@segments[i].location, target_segment).to_unity.enlarge(@segment_diameter)
          @segments[i].location = destination.head
          target_segment = @segments[i]
      end
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

  def x
      head.x
  end

  def y
      head.y
  end

  def location
      head.location
  end

  def score
    @length
  end

  private
  def number_of_segments
    @segments.length
  end

  def length= length
    @length = length
    raise "You are dead" unless @length > 0

    length_difference = (@length.floor - number_of_segments).to_i
    if (length_difference > 0)
      add_segments length_difference
    elsif
      remove_segments -length_difference
    end
  end

  def add_segments count
    count.times do |i|
      @segments << Segment.new(@game, Point.new(0,0))
    end
  end

  def remove_segments count
    @segments.pop(count)
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
      self.length += (1.0 * food.grow_factor / number_of_segments)
      @game.universe.food.destroy food
    end
  end
end
