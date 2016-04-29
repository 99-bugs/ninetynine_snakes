require File.expand_path("../../ip_address", __FILE__)

class InputScreen

  def initialize(window, callback=nil)
    @window = window
    # Use array to keep ordering
    @input_fields = []
    @callback = callback
  end

  def add_input(font, label, key, type, initial=nil)
    field = nil
    if (type == :ip_address)
      field = IpAddress.new(@window, font, 100, 80+@input_fields.count*font.height*3)
    else
      field = TextField.new(@window, font, 100, 80+@input_fields.count*font.height*3)
    end

    @input_fields << {
      key: key,
      label: label,
      field: field,
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
end