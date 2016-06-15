class MainMenuScene < Scene

  def initialize universe, camera, input_manager
    super

    @text_object = Gosu::Font.new(@game_window, 'Ubuntu Sans', 24)

    @menu = Menu.new(@game_window)
    @menu.add('Start Singleplayer Game', lambda { @game_window.start_single_player })
    @menu.add('Start Multiplayer Game', lambda { @game_window.show_multiplayer_connect })
    @menu.add('Options', lambda { puts "Showing Options"})
    @menu.add('Credits', lambda { puts "Showing Credits"})
    @menu.add('Exit Game', lambda { @game_window.close })
  end

  def draw
    super
    @menu.draw
  end

  def register_input_events
    super
    @input_manager.on_key_down(Gosu::MsLeft) { |event| @menu.clicked(Point.new(@game_window.mouse_x, @game_window.mouse_y)) }
  end
end