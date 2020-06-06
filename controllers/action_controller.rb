# Allows us to translate user input to a behavior
class ActionController
  X_SPEED = 2
  Y_SPEED = 1

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

    update_treats
  end

  private

  def perform_up
    return if @cat.y <= (Y_SPEED - 1)

    @cat.y -= Y_SPEED
  end

  def perform_left
    return if @cat.x <= (X_SPEED - 1)

    @cat.x -= X_SPEED
  end

  def perform_down
    return if @cat.y >= @maze.height - (Y_SPEED - 1)

    @cat.y += Y_SPEED
  end

  def perform_right
    return if @cat.x >= @maze.width - (X_SPEED - 1)

    @cat.x += X_SPEED
  end

  def update_treats
    @treats.delete_if do |treat|
      (treat.x > @cat.x - X_SPEED && treat.x <= @cat.x) &&
        (treat.y > @cat.y - Y_SPEED && treat.y <= @cat.y)
    end
  end
end
