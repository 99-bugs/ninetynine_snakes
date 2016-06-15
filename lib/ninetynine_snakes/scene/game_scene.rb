class GameScene < Scene
  def initialize universe, camera, input_manager
    super

    # Direction vector is based on center of window (because so are mouse coordinates)
    @current_heading = (Vector.new(Point.new(0,0), @game_window.center)).to_unity
  end

  def update
    super

    update_target_location

    # Move snake towards current heading
    begin
      @player.update(@current_heading)
    rescue YouDied => die
      @game_window.game_over!
    end
    
    @universe.update

    @camera.update(@player.location)
  end

  def draw
    super

    Gosu::translate(@camera.x, @camera.y) do
      @universe.draw
    end
  end

  def register_input_events
    super
    unless @game_window.configuration.use_mouse?
      @input_manager.on_key_down(Gosu::KbLeft) { |event| @current_heading = Vector.new(Point.new(-1, 0), Point.new(0, 0)) }
      @input_manager.on_key_down(Gosu::KbRight) { |event| @current_heading = Vector.new(Point.new(1, 0), Point.new(0, 0)) }
      @input_manager.on_key_down(Gosu::KbUp) { |event| @current_heading = Vector.new(Point.new(0, -1), Point.new(0, 0)) }
      @input_manager.on_key_down(Gosu::KbDown) { |event| @current_heading = Vector.new(Point.new(0, 1), Point.new(0, 0)) }
    end
  end

  private
  def update_target_location
    if @game_window.configuration.use_mouse?
      # Determine direction vector from center to current location of mouse
      mouse = Point.new(@game_window.mouse_x, @game_window.mouse_y)
      @current_heading = (Vector.new(mouse, @game_window.center)).to_direction
    end
  end
end
