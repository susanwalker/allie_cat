# Allows game.rb to use Cat defined in models/cat.rb
require './entities/cat'
require './entities/maze'
require './entities/treat'
require './entities/wall'
require './components/user_input_processor'
require './interfaces/terminal'

# variable cat and class Cat
cat = Cat.new(0, 0)

# backtics are used call terminal commands
# backtics always return a string because that's terminal output, so
# we call to_i to convert the string to integer
# termimal width and height need to be integers bc we are comparing them to
# cat position
terminal_height = `tput li`.to_i
terminal_width = `tput co`.to_i

# TODO: extract this to a maze generator
walls = [
  Wall.new(terminal_height / 2, 4, terminal_width / 4, 0),
  Wall.new(2, terminal_width / 4, 3 * terminal_width / 8, terminal_height / 4)
]

# TODO: extract this to maze generator
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
  # Clears entire terminal and renders again after each input
  terminal.clear
  uip.process_input

  terminal.render
# This happens when we hit Ctrl-C
# Ctrl-C is called signal. Therefore Ruby raises an exception called SignalException
# when it recieves Ctrl-C, therefore we need to rescue it in order to
# run any commands before exiting
rescue SignalException
  terminal.before_exit
  exit
end
