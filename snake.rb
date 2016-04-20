class Snake

attr_accessor :direction, :xpos, :ypos, :speed, :length, :segments, :ticker

  def initialize(window)
    @window = window
    @xpos = 200
    @ypos = 200
    @segments = []
    @direction = "right"
    @head_segment = Segment.new(self, @window, [@xpos, @ypos])
    @segments.push(@head_segment)
    @speed = 2
    @length = 1

    # Counts down to lengthen the snake each tick when it has eaten an apple
    @ticker = 0
  end

  def draw
    # Draw the segments
    @segments.each do |s|
      s.draw
    end
  end

  def update_position

    add_segment
    @segments.shift(1) unless @ticker > 0

  end

  def add_segment
    
    if @direction == "left"
      xpos = @head_segment.xpos - @speed
      ypos = @head_segment.ypos
      new_segment = Segment.new(self, @window, [xpos, ypos])
    end

    if @direction == "right"
      xpos = @head_segment.xpos + @speed
      ypos = @head_segment.ypos
      new_segment = Segment.new(self, @window, [xpos, ypos])
    end

    if @direction == "up"
      xpos = @head_segment.xpos
      ypos = @head_segment.ypos - @speed
      new_segment = Segment.new(self, @window, [xpos, ypos])
    end

    if @direction == "down"
      xpos = @head_segment.xpos
      ypos = @head_segment.ypos + @speed
      new_segment = Segment.new(self, @window, [xpos, ypos])
    end

    @head_segment = new_segment
    @segments.push(@head_segment)

  end

  def ate_apple?(apple)
    if Gosu::distance(@head_segment.xpos, @head_segment.ypos, apple.xpos, apple.ypos) < 10
      return true
    end
  end

  def hit_self?
    segments = Array.new(@segments)
    if segments.length > 21
      # Remove the head segment from consideration
      segments.pop((10 * @speed))
      segments.each do |s|
        if Gosu::distance(@head_segment.xpos, @head_segment.ypos, s.xpos, s.ypos) < 11
          puts "true, head: #{@head_segment.xpos}, #{@head_segment.ypos}; seg: #{s.xpos}, #{s.ypos}"
          return true
        else
          next
        end
      end
      return false
    end

  end

  def outside_bounds?
    if @head_segment.xpos < 0 or @head_segment.xpos > 630
      return true
    elsif @head_segment.ypos < 0 or @head_segment.ypos > 470
      return true
    else
      return false
    end
  end

end