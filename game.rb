# This file is temporary and will be replaced by a combination of controller and
# views

# Allows game.rb to use Cat defined in models/cat.rb
require './entities/cat'
require './entities/maze'
require './entities/treat'
require './components/user_input_processor'
require './interfaces/terminal'

# variable cat and class Cat
cat = Cat.new(0, 0)

walls = []

# backtics are used call terminal commands
# backtics always return a string because that's terminal output, so
# we call to_i to convert the string to integer
# termimal width and height need to be integers bc we are comparing them to
# cat position
terminal_height = `tput li`.to_i
terminal_width = `tput co`.to_i

treats = [
  Treat.new(terminal_width / 2, terminal_height / 2),
  Treat.new(terminal_width / 2, 0)
]

maze = Maze.new(terminal_height, terminal_width, cat, treats, walls)

terminal = Terminal.new(maze)
terminal.init
terminal.render

loop do
  input = $stdin.getc
  uip = UserInputProcessor.new(input, maze)
  terminal.clear
  uip.process_input

  terminal.render
rescue SignalException
  terminal.before_exit
  exit
end
