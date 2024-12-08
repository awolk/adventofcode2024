require_relative './lib/aoc'
require_relative './lib/grid'

input = AOC.get_input(8)

grid = Grid.chars(input)
frequencies = input.chars.uniq - ['.', "\n"]

# Part 1
antinode_points = Set[]
frequencies.each do |freq|
  positions = grid.all_indexes(freq)
  positions.combination(2).each do |a, b|
    delta = b - a
    antinode_points << b + delta
    antinode_points << a - delta
  end
end
antinode_points.filter! {|pt| grid.valid_pos?(pt)}

pt1 = antinode_points.length
puts "Part 1: #{pt1}"

# Part 2
antinode_points = Set[]
frequencies.each do |freq|
  positions = grid.all_indexes(freq)
  positions.combination(2).each do |a, b|
    delta = b - a

    # from b
    pos = b
    while grid.valid_pos?(pos)
      antinode_points << pos
      pos += delta
    end

    # from a
    pos = a
    while grid.valid_pos?(pos)
      antinode_points << pos
      pos -= delta
    end
  end
end

pt2 = antinode_points.length
puts "Part 2: #{pt2}"
