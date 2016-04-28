class Configuration
	attr_accessor :use_mouse, :show_fps, :server_ip, :server_port, :nickname

	def initialize
		@use_mouse = true
		@show_fps = false
    @server_ip = "127.0.0.1"
    @server_port = 9956
    @nickname = "Guest" + rand(0..1000).to_s
	end
end