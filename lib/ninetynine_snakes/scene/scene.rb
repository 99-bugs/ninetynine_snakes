class Scene
  def initialize input_manager, game_window
    @input_manager = input_manager
    @game_window = game_window
    @cursor = Cursor.new(@game_window)

    register_input_events
  end

  def update
    @cursor.update
  end

  def draw
    # Always draw cursor
    @cursor.draw
  end

  def register_input_events
    @input_manager.on_key_down(Gosu::KbEscape) { |event| @game_window.close }
  end
end
