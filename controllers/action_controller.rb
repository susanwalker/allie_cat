# Allows us to translate user input to a behavior
class ActionController
  # initialize links to .new in game.rbj
  def initialize(user_input, cat, treats, maze)
    @user_input = user_input
    @cat = cat
    @treats = treats
    @maze = maze
  end

  # Allows us to get user input for directions, puts input (now removed)
  # allows to temporarily print characters for arrow keys
  # Up = A, down = B, left = D, right = C because ruby $stdin.getc interprets
  # up arrow as A, etc. 
  def process_input
    case @user_input
    when 'A' then perform_up
    when 'B' then perform_down
    when 'D' then perform_left
    when 'C' then perform_right
    end
  end

  private

  def perform_up
    return if @cat.y <= 0

    @cat.y -= 1
  end

  def perform_left
    return if @cat.x <= 1

    @cat.x -= 2
  end

  def perform_down
    return if @cat.y >= @maze.height

    @cat.y += 1
  end

  def perform_right
    return if @cat.x >= @maze.width - 1

    @cat.x += 2
  end
end
