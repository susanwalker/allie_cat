# This file is temporary and will be replaced by a combination of controller and
# views

# Allows game.rb to use Cat defined in models/cat.rb
require './models/cat'
require './models/maze'
require './models/treat'
require './controllers/action_controller'
require './views/terminal'

# variable cat and class Cat
cat = Cat.new(0, 0)

# backtics are used call terminal commands
# backtics always return a string because that's terminal output, so
# we call to_i to convert the string to integer
# termimal width and height need to be integers bc we are comparing them to
# cat position
terminal_height = `tput li`.to_i
terminal_width = `tput co`.to_i

maze = Maze.new(terminal_height, terminal_width)

treats = [
  Treat.new(terminal_width / 2, terminal_height / 2),
  Treat.new(terminal_width / 2, 0)
]

terminal = Terminal.new(cat, treats)
terminal.init
terminal.render

loop do
  input = $stdin.getc
  controller = ActionController.new(input, cat, treats, maze)
  terminal.clear
  controller.process_input

  terminal.render
rescue SignalException
  terminal.before_exit
  exit
end
