require_relative './lib/aoc'
require_relative './lib/grid'
require_relative './lib/parser'

input = AOC.get_input(10)
grid = Grid.digits(input)

pt1 = grid.all_indexes(0).sum do |th|
  # bfs
  heights = 0
  visited = Set[]
  to_visit = [th]
  while !to_visit.empty?
    visiting = to_visit.pop
    next if visited.include?(visiting)
    visited << visiting


    if grid[visiting] == 9
      heights += 1
    else
      visiting_val = grid[visiting]
      grid.neighbors_with_positions(visiting, diagonals: false).each do |neighbor, neighbor_pos|
        if neighbor == visiting_val + 1
          to_visit << neighbor_pos
        end
      end
    end
  end
  heights
end
puts "Part 1: #{pt1}"

# dfs
def paths(grid, so_far)
  pos = so_far.last
  if grid[pos] == 9
    return 1 
  end

  at_pos = grid[pos]
  grid.neighbors_with_positions(pos, diagonals: false).sum do |neighbor, neighbor_pos|
    next 0 if neighbor != at_pos + 1
    next 0 if so_far.include?(neighbor_pos)
    paths(grid, so_far + [neighbor_pos])
  end
end

pt2 = grid.all_indexes(0).sum do |th|
  paths(grid, [th])
end
puts "Part 2: #{pt2}"
