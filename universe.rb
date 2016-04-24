class Universe

  attr_accessor :dots, :snakes

  def initialize(window)
    @window = window
    @dots = []
    @snakes = []
  end

  def generate_random_dots(count)
    for i in 0..count do
      @dots << Dot.new(@window, Point.new(rand(0..1000), rand(0..1000)))
    end
  end

  def add_snake(snake)
    @snakes << snake
  end

  def check_for_dot_collisions
    number_of_dots = @dots.length

    snake = @snakes.first

    gravity_force = 10
    gravity_distance = 2.5 * snake.head.width / 2

    @near_dots = @dots.select { |d| Gosu::distance(snake.x, snake.y, d.x, d.y) < gravity_distance }
    @near_dots.each do |dot|
        distance = Gosu::distance(snake.x, snake.y, dot.x, dot.y)
        distance_factor = 1 - (distance / gravity_distance)
        if distance < gravity_distance
            dx = snake.x - dot.x
            dy = snake.y - dot.y
            dx = dx / gravity_force * distance_factor
            dy = dy / gravity_force * distance_factor
            dot.location.x += dx
            dot.location.y += dy
        end
    end


    @dots = @dots.select { |d| Gosu::distance(snake.x, snake.y, d.x, d.y) >  snake.head.width / 2 }

    if @dots.length < number_of_dots
      @snakes.first.grow(5*(number_of_dots - @dots.length))
    end
  end

  def draw
    @dots.each do |d|
      d.draw
    end
    @snakes.each do |s|
      s.draw
    end
  end
end
