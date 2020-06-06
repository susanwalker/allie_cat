# Defines Maze class as static height and width
class Maze
  # attr_reader allows to only read 
  attr_reader :height, :width

  def initialize(height, width)
    @height = height
    @width = width
  end
end
