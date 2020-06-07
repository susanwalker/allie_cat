class Terminal
  # def initialize allows us to call class.new
  def initialize(maze)
    @maze = maze
  end

  def render
    render_entity(@maze.cat)
    render_treats
  end

  def clear
    clear_entity(@maze.cat)
    clear_treats
  end

  # Initiaizes terminal and removes cursor and other settings
  def init
    system 'tput civis; stty -icanon; stty -echo; clear'
  end

  # This undoes init updates
  def before_exit
    system 'tput reset; stty icanon; stty echo; clear'
  end

  private

  def render_entity(entity)
    print "\033[#{entity.y};#{entity.x}H\033[0;33m#{entity.icon}"
  end

  def clear_entity(entity)
    clear_string = ''
    entity.width.times { clear_string << ' ' }
    print "\033[#{entity.y};#{entity.x}H\033[0;33m#{clear_string}"
  end

  def render_treats
    @maze.treats.each do |treat|
      render_entity(treat)
    end
  end

  def clear_treats
    @maze.treats.each do |treat|
      clear_entity(treat)
    end
  end
end
