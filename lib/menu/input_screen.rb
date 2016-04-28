class InputScreen

  def initialize(window, callback=nil)
    @window = window
    # Use array to keep ordering
    @input_fields = []
    @callback = callback
  end

  def add_input(font, label, key, initial=nil)
    @input_fields << {
      key: key,
      label: label,
      field: TextField.new(@window, font, 100, 80+@input_fields.count*font.height*3),
      font: font
    }
    @input_fields.last[:field].text = initial if !initial.nil?
  end

  def update
    if @window.button_down? Gosu::MsLeft
      # Mouse click: Select text field based on mouse position.
      input = @input_fields.find { |f| f[:field].under_point?(@window.mouse_x, @window.mouse_y) }
      @window.text_input = input[:field]
    elsif @window.button_down? Gosu::KbReturn   # Should be changed by OK button at bottom
      @callback.call
    end
  end

  def draw
    @input_fields.each_with_index do |f, i|
      f[:font].draw(f[:label], 100, 50+i*f[:font].height*3, 0)
      f[:field].draw
    end
  end

  def get_text(key)
    entry = @input_fields.find { |i| i[:key] == key }
    entry[:field].text
  end
end