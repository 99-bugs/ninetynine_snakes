class Configuration
	attr_accessor :use_mouse, :show_fps

	def initialize
		@use_mouse = true
		@show_fps = false
	end
end