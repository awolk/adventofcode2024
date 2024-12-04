require_relative './lib/aoc'
require_relative './lib/grid'

input = AOC.get_input(4)

deltas = [
  [0, 1],
  [1, 0],
  [0, -1],
  [-1, 0],
  [1, 1],
  [1, -1],
  [-1, 1],
  [-1, -1]
]

grid = Grid.chars(input)
total_xmas = 0
(0 .. grid.row_count).each do |row|
  (0 .. grid.column_count).each do |col|
    deltas.each do |dr, dc|
      positions = (0..3).map do |d|
        [row + d * dr, col + d * dc]
      end

      if !positions.all? {|pos| grid.valid_pos?(pos)}
        next
      end

      at_positions = positions.map {|pos| grid[pos]}.join

      if at_positions == 'XMAS'
        total_xmas += 1
      end
    end
  end
end

pt1 = total_xmas
puts "Part 1: #{pt1}"

pt2 = 0
(0 .. grid.row_count - 3).each do |tl_row|
  (0 .. grid.column_count - 3).each do |tl_col|
    subsection = Grid.new(grid.rows[tl_row ... tl_row + 3].map {|row| row[tl_col ... tl_col + 3]})
    next if subsection[1, 1] != 'A'
    # diagonals
    d1 = [subsection[0, 0], subsection[2, 2]].sort.join
    d2 = [subsection[2, 0], subsection[0, 2]].sort.join
    if d1 == 'MS' && d2 == 'MS'
      pt2 += 1
    end
    # crosses
    c1 = [subsection[1, 0], subsection[1, 2]].sort.join
    c2 = [subsection[0, 1], subsection[2, 1]].sort.join
    if c1 == 'SM' && c2 == 'MS'
      pt2 += 1
    end
  end
end

puts "Part 2: #{pt2}"
