#require '../2d/point.rb'

class Background

  def initialize(game)
    @game = game
    @background_image = @game.texturemanager.load_image('background3.jpg', 'background')
    @z_index = -100
    @location = Point.new
  end

  def update location
    @location = location
  end


  def draw
    image_height = @background_image.height
    image_width = @background_image.width

    vertical_tiles = (@game.height.to_f / image_height.to_f).ceil + 1
    horizonal_tiles = (@game.width.to_f / image_height.to_f).ceil + 1
    horizonal_tiles.times { |row|
        vertical_tiles.times { |column|
            @background_image.draw(
              (((@location.x / image_height).floor + column) * image_height) - ((image_height * (vertical_tiles - 1 )) / 2),
              (((@location.y / image_width ).floor + row   ) * image_width ) - ((image_width *  (horizonal_tiles - 1)) / 2),
              @z_index
            )
        }
    }
  end


end
