class Terminal
  # def initialize allows us to call class.new
  def initialize(maze)
    @maze = maze
  end

  def render
    render_entity(@maze.cat)

    @maze.walls.each do |wall|
      render_wall(wall)
    end

    @maze.treats.each do |treat|
      render_entity(treat)
    end
  end

  def clear
    clear_entity(@maze.cat)

    @maze.walls.each do |wall|
      clear_wall(wall)
    end

    @maze.treats.each do |treat|
      clear_entity(treat)
    end
  end

  # Initiaizes terminal and removes cursor and other settings
  # NCurses
  def init
    system 'tput civis; stty -icanon; stty -echo; clear'
  end

  # This undoes init updates
  def before_exit
    system 'tput reset; stty icanon; stty echo; clear'
  end

  private
  # private methods are only called in the defining class itself
  # helps with keeping code organized and self-documents code
  # "interface segreation"

  def render_entity(entity)
    print "\033[#{entity.y};#{entity.x}H\033[0;33m#{entity.icon}"
  end

  def clear_entity(entity)
    clear_string = ''
    # defined as an empty string, then append spaces equal to the width of the
    # entity
    entity.width.times do
      clear_string << ' '
    end

    print "\033[#{entity.y};#{entity.x}H\033[0;33m#{clear_string}"
  end

  def render_wall(wall)
    wall_string = ''
    wall.width.times do
      wall_string << '|'
    end

    wall.height.times do |index|
      print "\033[#{wall.y + index};#{wall.x}H\033[0;33m#{wall_string}"
    end
  end

  def clear_wall(wall)
    clear_string = ''
    wall.width.times do
      clear_string << ' '
    end

    wall.height.times do |index|
      print "\033[#{wall.y + index};#{wall.x}H\033[0;33m#{clear_string}"
    end
  end
end
