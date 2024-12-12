require_relative './lib/aoc'
require_relative './lib/grid'
require_relative './lib/parser'

input = AOC.get_input(12)
# input = AOC.get_example_input(12)

grid = Grid.chars(input)


visited = Set[]
pt1 = grid.each_with_index.sum do |plant, pos|
  next 0 if visited.include?(pos)

  # flood fill
  region = Set[]
  free_edges = 0
  to_visit = [pos]
  while !to_visit.empty?
    visiting = to_visit.pop
    next if region.include?(visiting)
      
    region << visiting
    visited << visiting
    nonfree_edges = 0
    grid.neighbors_with_positions(visiting, diagonals: false).each do |neighbor, neighbor_pos|
      if neighbor == plant
        nonfree_edges += 1
        to_visit << neighbor_pos
      end
    end
    free_edges += 4 - nonfree_edges
  end

  region.size * free_edges
end
puts "Part 1: #{pt1}"

pt2 = 0
puts "Part 2: #{pt2}"
