class Universe

  attr_accessor :dots, :snakes

  def initialize(window)
    @window = window
    @dots = []
    @snakes = []
  end

  def generate_random_dots(count)
    for i in 0..count do
      @dots << Dot.new(@window, Point.new(rand(0..1000), rand(0..1000)))
    end
  end

  def add_snake(snake)
    @snakes << snake
  end

  def check_for_dot_collisions
    number_of_dots = @dots.length
    @dots = @dots.select { |d| Gosu::distance(@snakes.first.x, @snakes.first.y, d.x, d.y) > 10 }

    if @dots.length < number_of_dots
      @snakes.first.grow(5*(number_of_dots - @dots.length))
    end
  end

  def draw
    @dots.each do |d|
      d.draw
    end
    @snakes.each do |s|
      s.draw
    end
  end
end