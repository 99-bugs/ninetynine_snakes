require './lib/menu/menu_item'

class Menu
  FONT_SIZE = 48
  FONT_NAME = 'Ubuntu Sans'

  def initialize(window)
    @window = window
    @entries = []
  end

  def add(text, callback)
    item = MenuItem.new(@window, text,
      Point.new(@window.center.x, 0),   # Temporary location
      FONT_SIZE, FONT_NAME, callback)

    @entries << item

    # Now we still need to recalculate the locations of the already added items
    @entries.each_with_index do |e, i|
      if (@entries.length % 2 != 0)
        y = @window.center.y + 1.2*FONT_SIZE*(i-@entries.length/2)
      else
        # Cannot use above or two middle items will be spaced twice as much
        # Need to include offset
        d = (i < @entries.length/2) ? i : i+1
        sign = ((d-@entries.length/2) <=> 0)
        offset = sign*1.2*(FONT_SIZE/2)
        y = @window.center.y + 1.2*FONT_SIZE*(d-@entries.length/2) - offset
      end

      e.location = Point.new(@window.center.x, y)
    end
  end

  def draw
    @entries.each do |e|
      e.draw
    end
  end
end