class InputScene < Scene

  def initialize input_manager, game_window, callback=nil
    super(input_manager, game_window)

    # Use array to keep ordering
    @input_fields = []
    @callback = callback
  end

  def add_input(font, label, key, type, initial=nil)
    field = nil
    if (type == :ip_address)
      field = IpAddress.new(@game_window, font, 100, 80+@input_fields.count*font.height*3)
    else
      field = TextField.new(@game_window, font, 100, 80+@input_fields.count*font.height*3)
    end

    @input_fields << {
      key: key,
      label: label,
      field: field,
      font: font
    }
    @input_fields.last[:field].text = initial if !initial.nil?
  end

  def draw
    super
    @input_fields.each_with_index do |f, i|
      f[:font].draw(f[:label], 100, 50+i*f[:font].height*3, 0)
      f[:field].draw
    end
  end

  def get_input(key)
    entry = @input_fields.find { |i| i[:key] == key }
    return entry[:field]
  end

  def all_validates?
    valid = true
    @input_fields.each do |f|
      valid = valid && f[:field].validates?
    end
    return valid
  end

  def validate_all!
    @input_fields.each do |f|
      f[:field].validate!
    end
  end

  def register_input_events
    super
    @input_manager.on_key_down(Gosu::MsLeft) do |event|
      # Mouse click: Select text field based on mouse position.
      input = @input_fields.find { |f| f[:field].under_point?(@game_window.mouse_x, @game_window.mouse_y) }
      @game_window.text_input = input[:field] if input
    end
    @input_manager.on_key_down(Gosu::KbReturn) { |event| @callback.call if @callback }
    @input_manager.on_key_down(Gosu::KbEscape) { |event| @game_window.start_main_menu }
  end

end
