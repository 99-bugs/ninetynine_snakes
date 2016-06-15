require "ninetynine_snakes/version"

require 'gosu'
require 'ninetynine_snakes/2d/point'
require 'ninetynine_snakes/2d/vector'
require 'ninetynine_snakes/sprite/sprite'
require 'ninetynine_snakes/assets/sound_manager'
require 'ninetynine_snakes/assets/sprite_manager'
require 'ninetynine_snakes/assets/texture_manager'
require 'ninetynine_snakes/menu/menu'
require 'ninetynine_snakes/menu/menu_item'
require 'ninetynine_snakes/menu/textfield'
require 'ninetynine_snakes/menu/ip_address'
require 'ninetynine_snakes/menu/input_screen'
require 'ninetynine_snakes/menu/options_screen_factory'
require 'ninetynine_snakes/game_objects/game_object'
require 'ninetynine_snakes/game_objects/dot'
require 'ninetynine_snakes/game_objects/bomb'
require 'ninetynine_snakes/game_objects/segment'
require 'ninetynine_snakes/game_objects/head'
require 'ninetynine_snakes/game_objects/cursor'
require 'ninetynine_snakes/game_objects/background'
require 'ninetynine_snakes/game_objects/food_manager'
require 'ninetynine_snakes/game_objects/snake_manager'
require 'ninetynine_snakes/input/input_manager'
require 'ninetynine_snakes/scene/scene'
require 'ninetynine_snakes/scene/game_scene'
require 'ninetynine_snakes/scene/scoreboard_scene'
require 'ninetynine_snakes/scene/main_menu_scene'
require 'ninetynine_snakes/scene/input_scene'
require 'ninetynine_snakes/scene/multiplayer_connect_scene'
require 'ninetynine_snakes/configuration/configuration'
require 'ninetynine_snakes/snake'
require 'ninetynine_snakes/universe'
require 'ninetynine_snakes/camera'
require 'ninetynine_snakes/client'

module NinetynineSnakes
  class GameWindow < Gosu::Window
    attr_reader :soundmanager,
                :texturemanager,
                :spritemanager,
                :center,
                :universe,
                :server,
                :input_manager,
                :configuration

    def initialize width=800,height=450
      
      super width, height, false
      self.caption = "99-Snakes"
      @text_object = Gosu::Font.new(self, 'Ubuntu Sans', 24)

      @configuration = Configuration.new

      @soundmanager = SoundManager.new
      @texturemanager = TextureManager.new(self)
      @spritemanager = SpriteManager.new(self)
      @input_manager = InputManager.new

      # Create the game universe
      @universe = Universe.new(self)
      @player = @universe.snakes.player

      # Create camera
      @camera = Camera.new(width, height)
      @camera.update(@player.location)

      @center = Point.new(width/2, height/2)

      show_main_menu
    end

    def update
      @scene.update
    end

    def button_down id
      @input_manager.button_down id
    end

    def button_up id
      @input_manager.button_up id
    end

    def draw
      # # Should really only render the current state of things and not change anything,
      # # not even advance animations.
      # # If you write draw in a functional, read-only style then you are safe.
      @scene.draw
    end

    def show_main_menu
      @scene = MainMenuScene.new @universe, @camera, @input_manager
    end

    def game_over!
      @scene = ScoreboardScene.new @universe, @camera, @input_manager
    end

    def start_single_player
      @scene = GameScene.new @universe, @camera, @input_manager
    end

    def show_multiplayer_connect
      @scene = MultiplayerConnectScene.new @universe, @camera, @input_manager
    end

    def start_multiplayer nickname, server_ip
      @server = Client.new self, nickname, server_ip
      @scene = GameScene.new @universe, @camera, @input_manager
    end
  end
end
