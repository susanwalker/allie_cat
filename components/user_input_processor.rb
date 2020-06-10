# Allows us to translate user input to a behavior
class UserInputProcessor
  X_SPEED = 2
  Y_SPEED = 1

  # initialize links to .new in game.rbj
  def initialize(user_input, maze)
    @user_input = user_input
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
  
  def overlapping?(entity_1, entity_2)
    (
      entity_1.x >= entity_2.x && (entity_1.x < (entity_2.x + entity_2.width)) ||
      entity_2.x >= entity_1.x && (entity_2.x < (entity_1.x + entity_1.width))
    ) &&
    (
      entity_1.y >= entity_2.y && (entity_1.y < (entity_2.y + entity_2.height)) ||
      entity_2.y >= entity_1.y && (entity_2.y < (entity_1.y + entity_1.height))
    )
  end

  private

  def perform_up
    return if @maze.cat.y < Y_SPEED

    @maze.cat.y -= Y_SPEED # same as @maze.cat.y = @maze.cat.y - Y_SPEED

    if @maze.walls.any? { |wall| overlapping?(@maze.cat, wall) }
      @maze.cat.y += Y_SPEED
    end
  end

  def perform_left
    return if @maze.cat.x < X_SPEED

    @maze.cat.x -= X_SPEED

    if @maze.walls.any? { |wall| overlapping?(@maze.cat, wall) }
      @maze.cat.x += X_SPEED
    end
  end

  def perform_down
    return if @maze.cat.y > @maze.height - Y_SPEED

    @maze.cat.y += Y_SPEED

    if @maze.walls.any? { |wall| overlapping?(@maze.cat, wall) }
      @maze.cat.y -= Y_SPEED
    end
  end

  def perform_right
    return if @maze.cat.x > @maze.width - X_SPEED

    @maze.cat.x += X_SPEED

    if @maze.walls.any? { |wall| overlapping?(@maze.cat, wall) }
      @maze.cat.x -= X_SPEED
    end
  end

  def update_treats
    @maze.treats.delete_if do |treat|
      overlapping?(@maze.cat, treat)
    end
  end
end
