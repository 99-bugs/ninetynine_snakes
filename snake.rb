require './lib/2d/vector'

class Snake

  attr_accessor :size   # Diameter of segments
  attr_reader :length
  attr_accessor :score

  def initialize(game, start_length=5, size=10)
    @segments = []
    @game = game
    @size = size
    @speed = 5
    @turn_radius = 30
    @length = 1.0*start_length
    @score = 0.0

    start_length.times do |i|
      @segments << Segment.new(@game, Point.new(100, 100+i*@size))
    end
    @prev_angle = 0

    @gravity = {
        force: 10,
        distance: 2.5 * head.width / 2  #note: head.width => sprite width !
    }
  end

  def update(direction_vector)
      delta_angle = direction_vector.angle - @prev_angle
      delta_angle += Math::PI * 2 while delta_angle < Math::PI
      delta_angle -= Math::PI * 2 while delta_angle > Math::PI
      angle = @prev_angle + delta_angle / @turn_radius

      move_head angle
      move_body

      suck_in_nearby_food
      eat_closeby_food
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

  def eat food

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
      #@score += food.score
      @game.universe.food.destroy food
    end


    # # Determine snake growth
    # grow_length = 0
    # eaten.each do |e|
    #   grow_length += 1.0 * e.grow_factor / @snakes.player.number_of_segments
    #   if (e.kind_of?(Bomb))
    #     @window.soundmanager.play('eat_bomb')
    #   else
    #     @window.soundmanager.play('eat_dot')
    #   end
    # end
    # @snakes.player.grow(grow_length)
    #
    # # Give snake score
    # if (grow_length > 0)
    #   score = 5 * grow_length
    # else
    #   score = 1 * grow_length
    # end
    # @snakes.player.score += score

  end

end
