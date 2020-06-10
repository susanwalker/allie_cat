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

num_walls = [3, 4, 5].sample
walls = []

def generate_wall(terminal_height, terminal_width)
  wall_height = (2..(terminal_height / 2)).to_a.sample
  wall_width = (2..(terminal_width / 2)).to_a.sample
  wall_x = (1..(terminal_width - 1)).to_a.sample
  wall_y = (1..(terminal_height - 1)).to_a.sample

  Wall.new(wall_height, wall_width, wall_x, wall_y)
end

num_walls.times do
  wall = generate_wall(terminal_height, terminal_width)

  walls << wall unless overlapping?(wall, cat)
end

num_treats = (10..15).to_a.sample
treats = []

def generate_treat(terminal_height, terminal_width)
  treat_x = (1..(terminal_width - 1)).to_a.sample
  treat_y = (1..(terminal_height - 1)).to_a.sample

  Treat.new(treat_x, treat_y)
end

num_treats.times do
  treat = generate_treat(terminal_height, terminal_width)

  unless overlapping?(treat, cat) || walls.any? { |wall| overlapping?(treat, wall) }
    treats << treat
  end
end

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
