class MenuItem
  attr_writer :location
  attr_reader :text

  def initialize(window, text, location, fontsize, fontname, callback)
    @window = window
    @location = location
    @callback = callback
    @text = text
    @message = Gosu::Image.from_text(window, text, fontname, fontsize)
  end

  def draw
    @message.draw_rot(@location.x, @location.y, 0, 0.5, 0.5)
  end

  def click
    if (!@callback.nil?)
      @callback.call
    end
  end

  def boundaries
    x1 = @location.x - @message.width/2
    x2 = @location.x + @message.width/2
    y1 = @location.y - @message.height/2
    y2 = @location.y + @message.height/2
    return {
      top_left: Point.new(x1, y1),
      bottom_right: Point.new(x2, y2)
    }
  end
end