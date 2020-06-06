class Terminal
  # def initialize allows us to call class.new
  def initialize(cat, treats)
    @cat = cat
    @treats = treats
  end

  def render
    render_cat
    render_treats
  end

  def clear
    clear_cat
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

  def render_cat
    print "\033[#{@cat.y};#{@cat.x}H\033[0;33m#{@cat.icon} "
  end

  def clear_cat
    print "\033[#{@cat.y};#{@cat.x}H\033[0;33m       "
  end

  def render_treats
    @treats.each do |treat|
      render_treat(treat)
    end
  end

  def render_treat(treat)
    print "\033[#{treat.y};#{treat.x}H\033[0;33m#{treat.icon} "
  end

  def clear_treats
    @treats.each do |treat|
      clear_treat(treat)
    end
  end

  def clear_treat(treat)
    print "\033[#{treat.y};#{treat.x}H\033[0;33m "
  end
end
