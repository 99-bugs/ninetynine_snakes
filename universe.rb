require './lib/game_objects/bomb'
require './lib/game_objects/dot'
require './lib/game_objects/segment'
require './lib/game_objects/cursor'
require './snake'

class Universe

  attr_accessor :dots, :snakes

  def initialize(window)
    @window = window
    @dots = []
    @snakes = []

    # Load assets
    @window.texturemanager.load_image('background3.jpg', 'background')
    @window.soundmanager.load_file('eat_dot.wav', 'eat_dot')
    @window.soundmanager.load_file('eat_bomb.wav', 'eat_bomb')
  end

  def generate_random_dots(count)
    for i in 0..count do
      @dots << Dot.new(@window, Point.new(rand(0..1000), rand(0..1000)))
    end
  end

  def generate_random_bombs(count)
    for i in 0..count do
      @dots << Bomb.new(@window, Point.new(rand(0..1000), rand(0..1000)))
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

    # Determine the things the snake ate
    eaten = @dots.select { |d| Gosu::distance(snake.x, snake.y, d.x, d.y) <=  snake.head.width / 2 }

    # Determine remaining dots
    @dots = @dots.select { |d| Gosu::distance(snake.x, snake.y, d.x, d.y) >  snake.head.width / 2 }

    # Determine snake growth
    grow_length = 0
    eaten.each do |e|
      grow_length += 1.0 * e.grow_factor / @snakes.first.number_of_segments
      if (e.kind_of?(Bomb))
        @window.soundmanager.play('eat_bomb')
      else
        @window.soundmanager.play('eat_dot')
      end
    end
    @snakes.first.grow(grow_length)

    # Give snake score
    if (grow_length > 0)
      score = 5 * grow_length
    else
      score = 1 * grow_length
    end
    @snakes.first.score += score
  end

  def update
      @dots.each do |dot|
          dot.update
      end
      check_for_dot_collisions
  end

  def draw
      background = @window.texturemanager.get_image('background')
      snake = @snakes.first
      vertical_tiles = (@window.height.to_f / background.height.to_f).ceil + 1
      horizonal_tiles = (@window.width.to_f / background.width.to_f).ceil + 1
      horizonal_tiles.times { |row|
          vertical_tiles.times { |column|
              background.draw(
                (((snake.location.x / background.height).floor + column) * background.height) - ((background.height * (vertical_tiles - 1)) / 2),
                (((snake.location.y / background.width).floor + row) * background.width) - ((background.width * (horizonal_tiles - 1)) / 2),
                -100
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
