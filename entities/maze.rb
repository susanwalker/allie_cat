# Defines Maze class as static height and width
class Maze
  # attr_reader allows to only read
  attr_reader :height, :width

  attr_accessor :cat, :treats, :walls

  def initialize(height, width, cat, treats, walls)
    @height = height
    @width = width
    @cat = cat
    @treats = treats
    @walls = walls
  end
end
