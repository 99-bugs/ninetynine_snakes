require "ninetynine_snakes/version"

require 'gosu'
require 'ninetynine_snakes/universe'
require 'ninetynine_snakes/camera'
require 'ninetynine_snakes/assets/sound_manager'
require 'ninetynine_snakes/assets/texture_manager'
require 'ninetynine_snakes/menu/menu'
require 'ninetynine_snakes/configuration'
require 'ninetynine_snakes/textfield'
require 'ninetynine_snakes/menu/input_screen'
require 'ninetynine_snakes/menu/options_screen_factory'
require 'ninetynine_snakes/client'

module NinetynineSnakes
  class GameWindow < Gosu::Window
    attr_reader :soundmanager, :texturemanager, :center, :universe, :server

    def initialize
      super 800, 450, false
      self.caption = "99-Snakes"
      @text_object = Gosu::Font.new(self, 'Ubuntu Sans', 24)

      @soundmanager = SoundManager.new
      @texturemanager = TextureManager.new(self)

      @client = Client.new self, "littlewan"

      # Create the game universe
      @universe = Universe.new(self)
      @player = @universe.snakes.player

      @cursor = Cursor.new(self)

      # Create camera
      @camera = Camera.new(width, height)
      @camera.update(@player.location)

      # Direction vector is based on center of window (because so are mouse coordinates)
      @center = Point.new(width/2, height/2)
      @dir_vector = (Vector.new(Point.new(0,0), @center)).to_unity

      # Create a menu
      build_menu

      # Game state
      @game_state = :main_menu

      @configuration = Configuration.new

      # Build multiplayer screen
      build_multiplayer_info_screen
    end

    def build_menu
      @menu = Menu.new(self)
      @menu.add('Start Singleplayer Game', lambda { @game_state = :playing })
      @menu.add('Start Multiplayer Game', lambda { @game_state = :multiplayer_server })
      @menu.add('Options', lambda { puts "Showing Options"})
      @menu.add('Credits', lambda { puts "Showing Credits"})
      @menu.add('Exit Game', lambda { self.close })
    end

    def build_multiplayer_info_screen
      @multiplayer_info_screen = OptionsScreenFactory.build_multiplayer_start_screen(self,
        @text_object, @configuration, method(:multiplayer_info_callback))
    end

    def multiplayer_info_callback
      if (@multiplayer_info_screen.all_validates?)
        @configuration.server_ip = @multiplayer_info_screen.get_input('server_ip').text
        @configuration.nickname = @multiplayer_info_screen.get_input('nickname').text

        # Change gamestate
        @gamestate = :multiplayer
      else
        @multiplayer_info_screen.validate_all!
      end
    end

    def update_target_location
      if (@configuration.use_mouse)
        # First we need to determine the direction vector from the middle of the window
        # toward the current location of the mouse pointer
        mouse = Point.new(mouse_x, mouse_y)
        @dir_vector = (Vector.new(mouse, @center)).to_direction
      else
        if button_down? Gosu::KbLeft
          @dir_vector = Vector.new(Point.new(-1, 0), Point.new(0, 0))
        end
        if button_down? Gosu::KbRight
          @dir_vector = Vector.new(Point.new(1, 0), Point.new(0, 0))
        end
        if button_down? Gosu::KbUp
          @dir_vector = Vector.new(Point.new(0, -1), Point.new(0, 0))
        end
        if button_down? Gosu::KbDown
          @dir_vector = Vector.new(Point.new(0, 1), Point.new(0, 0))
        end
      end
    end

    def update
      @cursor.update
      if (@game_state == :playing || @gamestate == :multiplayer)
        update_target_location

        begin
          @universe.update
        rescue Exception => die
          @game_state = :game_over
          puts die
          puts die.backtrace
        end

        # Move the snake towards the mouse pointer
        @player.update(@dir_vector)
        @camera.update(@player.location)

        if (@gamestate == :multiplayer)
          @client.update @player
        end

        if button_down? Gosu::KbEscape
          @game_state = :main_menu
        end
      elsif @game_state == :main_menu
        if button_down? Gosu::MsLeft
          @menu.clicked(Point.new(mouse_x, mouse_y))
        end
      elsif @game_state == :multiplayer_server
        # Here we need to request some info from player about the server
        @multiplayer_info_screen.update
      end
    end

    def draw
      # Should really only render the current state of things and not change anything,
      # not even advance animations.
      # If you write draw in a functional, read-only style then you are safe.

      if (@game_state == :main_menu)
        @menu.draw
      elsif (@game_state == :playing)
        Gosu::translate(@camera.x, @camera.y) do
          @universe.draw
        end

        @text_object.draw("Score: #{@player.length.round(2)}",5,5,0)
        if (@configuration.show_fps)
          @text_object.draw("FPS: #{Gosu::fps}",430,5,0)
        end
      elsif (@game_state == :game_over)
        @text_object.draw("Score: #{@player.score.round(2)}",5,5,0)
        @text_object.draw("YOU ARE DEAD",200,200,0)
      elsif (@game_state == :multiplayer_server)
        @multiplayer_info_screen.draw
      end

      # Always draw cursor
      @cursor.draw
    end
  end
end
