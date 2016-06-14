class InvalidInputEvent < Exception; end

class InputManager

  def initialize
    @on_key_down = {}
    @on_key_up = {}
  end

  def on_key_down id, &block
    @on_key_down[id] = block
  end

  def on_key_up id, &block
    @on_key_up[id] = block
  end

  def button_down id
    @on_key_down[id].call({ :state => :key_down, :key_id => id}) if @on_key_down.has_key?(id) and @on_key_down[id]
  end

  def button_up id
    @on_key_up[id].call({ :state => :key_up, :key_id => id}) if @on_key_up.has_key?(id) and @on_key_up[id]
  end
end