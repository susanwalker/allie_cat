# Define Cat behavior
# Defines Cat icon and positions
class Cat
  # attr_accessor allows us to update x, y even after initialization
  # for example, see action controller class
  attr_accessor :x, :y

  def initialize(x_value, y_value)
    @x = x_value
    @y = y_value
  end

  def height
    1
  end

  def width
    icon.length
  end

  def icon
    "(>^_^<)"
  end
end
