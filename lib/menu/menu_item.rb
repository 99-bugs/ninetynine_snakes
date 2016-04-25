class MenuItem
  attr_writer :location

  def initialize(window, text, location, fontsize, fontname, callback)
    @location = location
    @callback = callback
    @message = Gosu::Image.from_text(window, text, fontname, fontsize)
  end

  def draw
    @message.draw_rot(@location.x, @location.y, 0, 0.5, 0.5)
  end
end