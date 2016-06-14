class Universe

  attr_accessor :food, :snakes, :game

  def initialize(window)
    @game = window
    @food = FoodManager.new @game
    @snakes = SnakeManager.new @game
    @background = Background.new @game
  end

  def update
      @background.update @snakes.player.location
      @food.update
      @snakes.update
  end

  def draw
    @background.draw
    @food.draw
    @snakes.draw
  end

  def player
    @snakes.player
  end

end
