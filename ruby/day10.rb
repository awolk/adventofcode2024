require_relative './lib/aoc'
require_relative './lib/grid'

input = AOC.get_input(10)
grid = Grid.digits(input)

def paths(grid, so_far)
  pos = so_far.last
  if grid[pos] == 9
    return [so_far]
  end

  at_pos = grid[pos]
  grid.neighbors_with_positions(pos, diagonals: false).flat_map do |val, neighbor|
    next [] if val != at_pos + 1
    next [] if so_far.include?(neighbor)
    paths(grid, so_far + [neighbor])
  end
end

paths_per_trailhead = grid.all_indexes(0).map {|th| paths(grid, [th])}

# for part one, find unique destinations per trailhead
pt1 = paths_per_trailhead.sum {|paths| paths.map(&:last).uniq.size}
puts "Part 1: #{pt1}"

pt2 = paths_per_trailhead.sum {|paths| paths.size}
puts "Part 2: #{pt2}"
