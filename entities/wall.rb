# Define Wall class
class Wall
  attr_reader :height, :width, :x, :y

  def initialize(height, width, x, y)
    @height = height
    @width = width
    @x = x
    @y = y
  end
end
