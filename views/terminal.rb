class Terminal
  def initialize(cat)
    @cat = cat
  end

  def render_cat
    print "\033[#{@cat.y};#{@cat.x}H\033[0;33m#{@cat.icon} "
  end

  def clear_cat
    print "\033[#{@cat.y};#{@cat.x}H\033[0;33m       "
  end

  # Initiaizes terminal and removes cursor and other settings
  def init
    system 'tput civis; stty -icanon; stty -echo; clear'
  end

  # This undoes init updates
  def before_exit
    system 'tput reset; stty icanon; stty echo; clear'
  end
end
