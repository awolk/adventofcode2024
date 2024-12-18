require_relative './lib/aoc'
require_relative './lib/grid'
require_relative './lib/parser'

input = AOC.get_input(15)
# input = AOC.get_example_input(15)

grid_s, moves = input.split("\n\n")
grid = Grid.chars(grid_s)

DIRS = {
  '^' => Grid::Vec2::UP,
  '<' => Grid::Vec2::LEFT,
  '>' => Grid::Vec2::RIGHT,
  'v' => Grid::Vec2::DOWN
}

robot_pos = grid.index('@')
grid[robot_pos] = '.'
moves.chars.each do |move|
  next if move == "\n"
  dir = DIRS[move]
  moved = robot_pos + dir
  case grid[moved]
  when '#'
  when 'O'
    # try to push box
    end_box_row = moved + dir
    while grid[end_box_row] == 'O'
      end_box_row += dir
    end
    if grid[end_box_row] == '.'
      # if we found a free space
      robot_pos = moved
      grid[moved] = '.'
      grid[end_box_row] = 'O'
    end
  else
    robot_pos = moved
  end
end

pt1 = grid.all_indexes('O').sum do |r, c|
  100 * r + c
end
puts "Part 1: #{pt1}"

# Part 2: todo

pt2 = 0
puts "Part 2: #{pt2}"
