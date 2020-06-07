# Defines class Treat as icon and allows us to give position
class Treat
  # attr_reader allows to only read not update x, y
  attr_reader :x, :y

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
    "*"
  end
end
