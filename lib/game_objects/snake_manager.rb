

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

  end

  def add_snake(snake)
    @snakes << snake
  end

  def player
    return @snakes.first
  end


end
