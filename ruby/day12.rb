require_relative './lib/aoc'
require_relative './lib/grid'

input = AOC.get_input(12)
grid = Grid.chars(input)

visited = Set[]
regions = grid.each_with_index.filter_map do |plant, pos|
  next if visited.include?(pos)

  # flood fill
  region = Set[]
  to_visit = [pos]
  while !to_visit.empty?
    visiting = to_visit.pop
    next if region.include?(visiting)
      
    region << visiting
    visited << visiting
    grid.neighbors_with_positions(visiting, diagonals: false).each do |neighbor, neighbor_pos|
      to_visit << neighbor_pos if neighbor == plant
    end
  end

  region
end

pt1 = regions.sum do |region|
  perimeter = region.sum do |pos|
    4 - (grid.neighbor_positions(pos, diagonals: false).to_set & region).size
  end

  perimeter * region.size
end
puts "Part 1: #{pt1}"

# a side runs along the `along` dimension
def border_sides(borders, along, each)
  borders.group_by(&each).values.sum do |positions|
    positions.map(&along).sort.chunk_while {|a, b| a + 1 == b}.count
  end
end

pt2 = regions.sum do |region|
  top_borders = []
  bottom_borders = []
  left_borders = []
  right_borders = []
  region.each do |pos|
    top_borders << pos if !region.include?(pos - [1, 0])
    bottom_borders << pos if !region.include?(pos + [1, 0])
    left_borders << pos if !region.include?(pos - [0, 1])
    right_borders << pos if !region.include?(pos + [0, 1])
  end

  sides = border_sides(top_borders, :c, :r)
  sides += border_sides(bottom_borders, :c, :r)
  sides += border_sides(left_borders, :r, :c)
  sides += border_sides(right_borders, :r, :c)
  sides * region.size
end
puts "Part 2: #{pt2}"
