require 'gosu'
require './segment'
require './apple'
require './snake'
require './dot'
require './vector'

class GameWindow < Gosu::Window
	def initialize
		super 640, 480, false
		self.caption = "Snake"
		@snake = Snake.new(self)
		@score = 0
		@text_object = Gosu::Font.new(self, 'Ubuntu Sans', 24)

		@dots = []
		@dots << Dot.new(self, Point.new(100, 23))
		@dots << Dot.new(self, Point.new(20, 20))
		@dots << Dot.new(self, Point.new(235, 323))
		@dots << Dot.new(self, Point.new(100, 300))

    @center = Point.new(width/2, height/2)
    @dir_vector = (Vector.new(Point.new(0,0), @center)).to_unity

    @draw_direction_vector = true

		@last_update_ms = 0
		# @apple = Apple.new(self)
	end

  def update_target_location
    # First we need to determine the direction vector from the middle of the window
    # toward the current location of the mouse pointer
    mouse = Point.new(mouse_x, mouse_y)
    @dir_vector = (Vector.new(mouse, @center)).to_unity
  end

  def move_scene
    update_target_location
    translation_vector = @dir_vector.clone.to_direction.enlarge(1).to_discrete.flip
    @dots.each do |d|
      d.location.translate_by_direction_vector(translation_vector)
    end
  end

	def update
		# Change the target location of the snake towards the mouse pointer
		# @snake.update_target_location

		# Determine time from last update and take care of possible wrap around
		if (Gosu::milliseconds() > @last_update_ms)
			interval = Gosu::milliseconds() - @last_update_ms
		else
			@last_update_ms = 0
			interval = 10
		end

		if (interval >= 10)
			# Move the snake towards the mouse pointer
			move_scene
			@last_update_ms = Gosu::milliseconds()
		end

		if button_down? Gosu::KbEscape
			self.close
		end

		# if @snake.ate_apple?(@apple)
		# 	@apple = Apple.new(self)
		# 	@score += 10
		# 	@snake.length += 10
			
		# 	# 11 because we subtract one at the end of the method anyway
		# 	@snake.ticker += 110
		# 	if @score % 100 == 0
		# 		@snake.speed += 0.5
		# 	end
		# end


		# if @new_game and button_down? Gosu::KbReturn
		# 	@new_game = nil
		# 	@score = 0
		# 	@snake = Snake.new(self)
		# 	@apple = Apple.new(self)
		# end

		# @snake.ticker -= 1 if @snake.ticker > 0
	end

	def draw
		# Should really only render the current state of things and not change anything,
		# not even advance animations.
		# If you write draw in a functional, read-only style then you are safe.

		if @new_game
			@new_game.draw("Your Score was #{@score}", 5, 200, 100)
			@new_game.draw("Press Return to Try Again", 5, 250, 100)
			@new_game.draw("Or Escape to Close", 5, 300, 100)
		else
			@snake.draw
	    @dots.each do |d|
	      d.draw
	    end

	    if (@draw_direction_vector)
	      large_dir_vec = @dir_vector.clone.enlarge(10).to_discrete
	      draw_line(large_dir_vec.origin.x, large_dir_vec.origin.y, Gosu::Color::GREEN, 
	        large_dir_vec.head.x, large_dir_vec.head.y, Gosu::Color::GREEN)
	    end

			@text_object.draw("Score: #{@score}",5,5,0)
			@text_object.draw("FPS: #{Gosu::fps}",430,5,0)
		end
	end
end

window = GameWindow.new
window.show
