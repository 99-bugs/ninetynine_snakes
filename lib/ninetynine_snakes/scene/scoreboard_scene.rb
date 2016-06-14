class ScoreboardScene < Scene

  def initialize universe, camera, input_manager
    super(universe, camera, input_manager)

    @universe = universe
    @camera = camera
    @player = @universe.snakes.player
    @input_manager = input_manager
    @game_window = @universe.game

    @text_object = Gosu::Font.new(@game_window, 'Ubuntu Sans', 24)
  end

  def update
    super
  end

  def draw
    super

    @text_object.draw("Score: #{@player.score.round(2)}",5,5,0)
    @text_object.draw("YOU ARE DEAD",200,200,0)
    @text_object.draw("Hit Escape to hit the Road",200,350,0)
  end
end

