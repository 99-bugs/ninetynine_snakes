class SnakeManager

  include Enumerable

  def initialize game
    @game = game
    @snakes = []
    add_snake(Snake.new(@game, 10))
  end

  def draw
    @snakes.each do |s|
      s.draw
    end
  end

  def update
      queue = @game.server.queue
      until queue.empty?
          data = queue.pop(true) rescue nil
          if data
              snake = @snakes.select {|snake| snake.id == data["id"]}.first
              if snake
                  snake.update_head_position data["location"]["x"], data["location"]["y"]
                  puts "update snake #{snake.id}"
              else
                  new_snake = Snake.new(@game, 10)
                  new_snake.id = data["id"]
                  @snakes << new_snake
                  puts "add new snake"
              end
          end
      end
  end

  def add_snake(snake)
    @snakes << snake
  end

  def player
    return @snakes.first
  end


end
