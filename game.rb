# This file is temporary and will be replaced by a combination of controller and
# views

# Allows game.rb to use Cat defined in models/cat.rb
require './models/cat'
require './models/maze'
require './controllers/action_controller'
require './views/terminal'

# variable cat and class Cat
cat = Cat.new(0, 0)

# backtics are used call terminal commands
# backtics always return a string because that's terminal output, so
# we call to_i to convert the string to integer
terminal_height = `tput li`.to_i
terminal_width = `tput co`.to_i

maze = Maze.new(terminal_height, terminal_width)

terminal = Terminal.new(cat)
terminal.init
terminal.render_cat

loop do
  input = $stdin.getc
  controller = ActionController.new(input, cat, nil, maze)
  terminal.clear_cat
  controller.process_input

  terminal.render_cat
rescue SignalException
  terminal.before_exit
  exit
end
