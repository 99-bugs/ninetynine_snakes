class Scene
  def initialize universe, camera, input_manager
    @universe = universe
    @camera = camera
    @player = @universe.snakes.player
    @input_manager = input_manager
    @game_window = @universe.game

    # Direction vector is based on center of window (because so are mouse coordinates)
    @current_heading = (Vector.new(Point.new(0,0), @game_window.center)).to_unity

    @use_mouse = true
    @cursor = Cursor.new(@game_window)

    register_input_events
  end

  def update
    @cursor.update
    update_target_location

    begin
      @universe.update
    rescue Exception => die
      # @game_state = :game_over
      puts die
      puts die.backtrace
    end

    # Move snake towards current heading
    @player.update(@current_heading)
    @camera.update(@player.location)
  end

  def draw
    Gosu::translate(@camera.x, @camera.y) do
      @universe.draw
    end

    # Always draw cursor
    @cursor.draw
  end

  private
  def update_target_location
    if (@use_mouse)
      # Determine direction vector from center to current location of mouse
      mouse = Point.new(@game_window.mouse_x, @game_window.mouse_y)
      @current_heading = (Vector.new(mouse, @game_window.center)).to_direction
    end
  end

  def register_input_events
    @input_manager.on_key_down(Gosu::KbEscape) { |event| @game_window.close }

    unless @use_mouse
      @input_manager.on_key_down(Gosu::KbLeft) { |event| @current_heading = Vector.new(Point.new(-1, 0), Point.new(0, 0)) }
      @input_manager.on_key_down(Gosu::KbRight) { |event| @current_heading = Vector.new(Point.new(1, 0), Point.new(0, 0)) }
      @input_manager.on_key_down(Gosu::KbUp) { |event| @current_heading = Vector.new(Point.new(0, -1), Point.new(0, 0)) }
      @input_manager.on_key_down(Gosu::KbDown) { |event| @current_heading = Vector.new(Point.new(0, 1), Point.new(0, 0)) }
    end
  end
end
