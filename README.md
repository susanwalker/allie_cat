# Allie Cat
A simple pacman type game with cats chasing cat treats. This game is a learning exercise in learning Ruby outside of Rails (no current score keeping or levels).

## Architecture

### Entities

 - Cat: an icon that has mutable x and y position
 - Treat: an icon that has fixed x ad y position and is cleared when overlapping Cat
 - Wall: a fixed barrier representation that blocks Cat movement
 - Maze: a composite of Wall and Treat components that form the environment that the Cat moves in

### Components

  - User Input Processor: processes user input using arrow keys, responsible for updating cat position, update treats, and detecting collisions between cat and walls

### Interfaces

 - Responsible for rendering entities in the game (within the terminal)

## TODO
- [X] entities
  - [X] Cat Class
  - [X] Maze Class
  - [X] Treat Class
  - [X] Wall Class
- [X] interfaces
- [X] user_input_processor
- [X] RSpec
