class Snake

  attr_accessor :head_segment, :dir_vector

  def initialize(window)
    @window = window
    @segments = []

    @center = Point.new(@window.width/2, @window.height/2)
    @head_segment = Segment.new(@window, @center)
    @segments << @head_segment

    # @center = Point.new(@window.width/2, @window.height/2)
    # @dir_vector = (Vector.new(Point.new(0,0), @center)).to_unity
    # @speed = 2

    # @target_location = Point.new(1, 1)

    # # Counts down to lengthen the snake each tick when it has eaten an apple
    # @ticker = 0

  end

  # Returns length of snake
  def length
    @segments.length
  end

  def draw
    # Draw the segments
    @segments.each do |s|
      s.draw
    end
  end



  # def move
  #   update_target_location
  #   puts @dir_vector.clone.to_direction.length
  #   @head_segment.location.translate_by_direction_vector(@dir_vector.clone.to_direction.enlarge(5).to_discrete)
  # end

  # def update_position
  #   loc = next_head_location
  #   add_segment(loc)
  #   @segments.shift(1) unless @ticker > 0
  # end

  # def next_head_location
  #   x1 = @location.x
  #   y1 = @location.y

  #   new_locations = []
  #   distances = []

  #   # Create possible next locations
  #   new_locations << Point.new(@target_location.x + 1, @target_location.y)
  #   new_locations << Point.new(@target_location.x, @target_location.y + 1)
  #   new_locations << Point.new(@target_location.x + 1, @target_location.y + 1)
  #   new_locations << Point.new(@target_location.x - 1, @target_location.y)
  #   new_locations << Point.new(@target_location.x, @target_location.y - 1)
  #   new_locations << Point.new(@target_location.x - 1, @target_location.y - 1)

  #   # Determine distance between each new location and the target location
  #   new_locations.each { |loc| distances << Math.sqrt((loc.x-x1)*(loc.x-x1) + (loc.y-y1)*(loc.y-y1))}

  #   new_locations[distances.index(distances.min)]
  # end

  # def add_segment(location)

  #   new_segment = Segment.new(self, @window, [location.x, location.y])
    
  #   # if @direction == "left"
  #   #   xpos = @head_segment.xpos - @speed
  #   #   ypos = @head_segment.ypos
  #   #   new_segment = Segment.new(self, @window, [xpos, ypos])
  #   # end

  #   # if @direction == "right"
  #   #   xpos = @head_segment.xpos + @speed
  #   #   ypos = @head_segment.ypos
  #   #   new_segment = Segment.new(self, @window, [xpos, ypos])
  #   # end

  #   # if @direction == "up"
  #   #   xpos = @head_segment.xpos
  #   #   ypos = @head_segment.ypos - @speed
  #   #   new_segment = Segment.new(self, @window, [xpos, ypos])
  #   # end

  #   # if @direction == "down"
  #   #   xpos = @head_segment.xpos
  #   #   ypos = @head_segment.ypos + @speed
  #   #   new_segment = Segment.new(self, @window, [xpos, ypos])
  #   # end

  #   @head_segment = new_segment
  #   @segments.push(@head_segment)

  # end

  # def ate_apple?(apple)
  #   if Gosu::distance(@head_segment.xpos, @head_segment.ypos, apple.xpos, apple.ypos) < 10
  #     return true
  #   end
  # end

  # def hit_self?
  #   segments = Array.new(@segments)
  #   if segments.length > 21
  #     # Remove the head segment from consideration
  #     segments.pop((10 * @speed))
  #     segments.each do |s|
  #       if Gosu::distance(@head_segment.xpos, @head_segment.ypos, s.xpos, s.ypos) < 11
  #         puts "true, head: #{@head_segment.xpos}, #{@head_segment.ypos}; seg: #{s.xpos}, #{s.ypos}"
  #         return true
  #       else
  #         next
  #       end
  #     end
  #     return false
  #   end

  # end

  # def outside_bounds?
  #   if @head_segment.xpos < 0 or @head_segment.xpos > 630
  #     return true
  #   elsif @head_segment.ypos < 0 or @head_segment.ypos > 470
  #     return true
  #   else
  #     return false
  #   end
  # end

end