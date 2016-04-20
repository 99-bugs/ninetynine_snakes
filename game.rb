require 'gosu'
require './segment'
require './apple'
require './snake'

class GameWindow < Gosu::Window
	def initialize
		super 640, 480, false
		self.caption = "Snake"
		@snake = Snake.new(self)
		@apple = Apple.new(self)
		@score = 0

		@text_object = Gosu::Font.new(self, 'Ubuntu Sans', 32)

	end

	def update

		# Change directions, but don't allow doubling back
		if button_down? Gosu::KbLeft and @snake.direction != "right"
			@snake.direction = "left"
		end
		if button_down? Gosu::KbRight and @snake.direction != "left"
			@snake.direction = "right"
		end
		if button_down? Gosu::KbUp and @snake.direction != "down"
			@snake.direction = "up"
		end
		if button_down? Gosu::KbDown and @snake.direction != "up"
			@snake.direction = "down"
		end

		if button_down? Gosu::KbEscape
			self.close
		end

		if @snake.ate_apple?(@apple)
			@apple = Apple.new(self)
			@score += 10
			@snake.length += 10
			
			# 11 because we subtract one at the end of the method anyway
			@snake.ticker += 11
			if @score % 100 == 0
				@snake.speed += 0.5
			end
		end

		if @snake.hit_self?
			@new_game = Gosu::Font.new(self, 'Ubuntu Sans', 32)
		end

		if @snake.outside_bounds?
			@new_game = Gosu::Font.new(self, 'Ubuntu Sans', 32)
		end

		if @new_game and button_down? Gosu::KbReturn
			@new_game = nil
			@score = 0
			@snake = Snake.new(self)
			@apple = Apple.new(self)
		end

		@snake.ticker -= 1 if @snake.ticker > 0
	end

	def draw

		if @new_game
			@new_game.draw("Your Score was #{@score}", 5, 200, 100)
			@new_game.draw("Press Return to Try Again", 5, 250, 100)
			@new_game.draw("Or Escape to Close", 5, 300, 100)
		else
			@snake.update_position
			@snake.draw
			@apple.draw
			@text_object.draw("Score: #{@score}",5,5,0)
		end
	end
end

window = GameWindow.new
window.show
