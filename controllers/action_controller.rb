class ActionController
  def initialize(user_input, cat, treats, maze)
    @user_input = user_input
    @cat = cat
    @treats = treats
    @maze = maze
  end

  def process_input
    case @user_input
      when 'w' then perform_up
      when 's' then perform_down
      when 'a' then perform_left
      when 'd' then perform_right
    end
  end

  private

  def perform_up
    return if @cat.y <= 0

    @cat.y -= 1
  end

  def perform_left
    return if @cat.x <= 0

    @cat.x -= 1
  end

  def perform_down
    return if @cat.y >= @maze.height

    @cat.y += 1
  end

  def perform_right
    return if @cat.x >= @maze.width

    @cat.x += 1
  end
end
