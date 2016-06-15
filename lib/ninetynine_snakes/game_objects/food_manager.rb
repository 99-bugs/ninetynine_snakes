class FoodManager

  def initialize game
      @game = game

      @food = []

      generate_random_dots(10)
      generate_random_bombs(100)
  end

  def update
    @food.each do |food|
        food.update
    end
  end

  def draw
    @food.each do |food|
      food.draw
    end
  end

  def generate_random_dots(count)
    for i in 0..count do
      @food << Dot.new(@game, Point.new(rand(0..1000), rand(0..1000)))
    end
  end

  def generate_random_bombs(count)
    for i in 0..count do
      @food << Bomb.new(@game, Point.new(rand(0..1000), rand(0..1000)))
    end
  end

  def get_nearby_food location, distance
    @food.select { |d| Gosu::distance(location.x, location.y, d.x, d.y) < distance }
  end

  def destroy food
    food.destroy
    @food.delete food
  end

end
