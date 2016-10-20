class ScoreboardScene < Scene

  def initialize input_manager, game_window, player
    super(input_manager, game_window)

    @player = player
    @text_object = Gosu::Font.new(@game_window, 'Ubuntu Sans', 24)
  end

  def draw
    super

    @text_object.draw("Score: #{@player.score.round(2)}",5,5,0)
    @text_object.draw("YOU ARE DEAD",200,200,0)
    @text_object.draw("Hit Escape to hit the Road",200,350,0)
  end
end
