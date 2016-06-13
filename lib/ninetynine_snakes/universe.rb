require 'ninetynine_snakes/game_objects/segment'
require 'ninetynine_snakes/game_objects/cursor'
require 'ninetynine_snakes/game_objects/background'
require 'ninetynine_snakes/game_objects/food_manager'
require 'ninetynine_snakes/game_objects/snake_manager'
require 'ninetynine_snakes/snake'

class Universe

  attr_accessor :food, :snakes

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