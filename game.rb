require 'gosu'
require './segment'
require './snake'
require './dot'
require './vector'
require './camera'
require './cursor'
require './universe'
require './lib/assets/sound_manager'
require './lib/assets/texture_manager'

class GameWindow < Gosu::Window
	attr_reader :soundmanager, :texturemanager

	def initialize
		super 640, 480, false
		self.caption = "Snake"
		@score = 0
		@text_object = Gosu::Font.new(self, 'Ubuntu Sans', 24)

		@soundmanager = SoundManager.new
		@texturemanager = TextureManager.new(self)

		# Create the game universe
		@universe = Universe.new(self)
		snake = Snake.new(self, 10)
		@universe.add_snake(snake)
		@universe.generate_random_dots(100)

		@cursor = Cursor.new(self)

		# Create camera
		@camera = Camera.new(width, height)
		@camera.tick(snake.location)

		# Direction vector is based on center of window (because so are mouse coordinates)
    	@center = Point.new(width/2, height/2)
    	@dir_vector = (Vector.new(Point.new(0,0), @center)).to_unity

		@use_mouse = true
	end

  def update_target_location
  	if (@use_mouse)
	    # First we need to determine the direction vector from the middle of the window
	    # toward the current location of the mouse pointer
	    mouse = Point.new(mouse_x, mouse_y)
	    @dir_vector = (Vector.new(mouse, @center)).to_direction
	  else
			if button_down? Gosu::KbLeft
				@dir = Vector.new(Point.new(-1, 0), Point.new(0, 0))
			end
			if button_down? Gosu::KbRight
				@dir = Vector.new(Point.new(1, 0), Point.new(0, 0))
			end
			if button_down? Gosu::KbUp
				@dir = Vector.new(Point.new(0, -1), Point.new(0, 0))
			end
			if button_down? Gosu::KbDown
				@dir = Vector.new(Point.new(0, 1), Point.new(0, 0))
			end
	  end
  end

	def update
		update_target_location

		snake = @universe.snakes.first
		@universe.update
		@cursor.update_position

		# Move the snake towards the mouse pointer
		snake.move(@dir_vector)
		@camera.tick(snake.location)

		if button_down? Gosu::KbEscape
			self.close
		end
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
			Gosu::translate(@camera.x, @camera.y) do
				@universe.draw
			end

			@cursor.draw
			@text_object.draw("Score: #{@score}",5,5,0)
			@text_object.draw("FPS: #{Gosu::fps}",430,5,0)
		end
	end
end

window = GameWindow.new
window.show
