require_relative './lib/aoc'
require_relative './lib/grid'

def equal_either_dir(a, b) = a == b || a == b.reverse

input = AOC.get_input(4)
grid = Grid.chars(input)

dirs = [[0, 1], [1, 0], [1, 1], [1, -1]]
pt1 = grid.each_with_index.sum do |_, (row, col)|
  dirs.count do |dr, dc|
    positions = 4.times.map do |steps|
      [row + steps * dr, col + steps * dc]
    end

    next false unless grid.valid_pos?(positions.last)

    at_positions = positions.map {grid[_1]}.join
    equal_either_dir(at_positions, 'XMAS')
  end
end
puts "Part 1: #{pt1}"

pt2 = grid.each_tile(3, 3).count do |tile|
  next false if tile[1, 1] != 'A'
  # check diagonals
  d1 = tile[0, 0] + tile[2, 2]
  d2 = tile[2, 0] + tile[0, 2]
  equal_either_dir(d1, 'MS') && equal_either_dir(d2, 'MS')
end
puts "Part 2: #{pt2}"
