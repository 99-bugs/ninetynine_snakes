class Universe

  attr_accessor :dots, :snakes

  def initialize(window)
    @window = window
    @dots = []
    @snakes = []
    @background = Gosu::Image.new(window,'./textures/background3.jpg', true)
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

    gravity = {
        force: 10,
        distance: 2.5 * snake.head.width / 2  #note: head.width => sprite width !
    }

    @near_dots = @dots.select { |d| Gosu::distance(snake.x, snake.y, d.x, d.y) < gravity[:distance] }
    @near_dots.each do |dot|
        distance = Gosu::distance(snake.x, snake.y, dot.x, dot.y)
        distance_factor = 1 - (distance / gravity[:distance])
        if distance < gravity[:distance]
            dx = snake.x - dot.x
            dy = snake.y - dot.y
            dx = dx / gravity[:force] * distance_factor
            dy = dy / gravity[:force] * distance_factor
            dot.center_location.x += dx
            dot.center_location.y += dy
        end
    end


    @dots = @dots.select { |d| Gosu::distance(snake.x, snake.y, d.x, d.y) >  snake.head.width / 2 }

    if @dots.length < number_of_dots
      @snakes.first.grow(5*(number_of_dots - @dots.length))
    end
  end

  def update
      @dots.each do |dot|
          dot.update
      end
      check_for_dot_collisions
  end

  def draw
      snake = @snakes.first
      vertical_tiles = (@window.height.to_f / @background.height.to_f).ceil + 1
      horizonal_tiles = (@window.width.to_f / @background.width.to_f).ceil + 1
      horizonal_tiles.times { |row|
          vertical_tiles.times { |column|
              @background.draw(
                (((snake.location.x / @background.height).floor + column) * @background.height) - ((@background.height * (vertical_tiles - 1)) / 2),
                (((snake.location.y / @background.width).floor + row) * @background.width) - ((@background.width * (horizonal_tiles - 1)) / 2),
                1
              )
          }
      }

    @dots.each do |d|
      d.draw
    end
    @snakes.each do |s|
      s.draw
    end
  end
end
