require './lib/game_objects/segment'
require './lib/game_objects/cursor'
require './lib/game_objects/background'
require './lib/game_objects/food_manager'
require './lib/game_objects/snake_manager'
require './snake'

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
      #check_for_dot_collisions
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
