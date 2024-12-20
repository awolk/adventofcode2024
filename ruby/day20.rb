require_relative './lib/aoc'
require_relative './lib/grid'

def good_cheats(path, max_dist, min_saved)
  path.each_with_index.sum do |pos, index|
    (index + min_saved + 2 ... path.length).count do |findex|
      fpos = path[findex]
      dist = pos.manhattan_dist(fpos)
      dist <= max_dist && findex - index - dist >= min_saved
    end
  end
end

input = AOC.get_input(20)
grid = Grid.chars(input)

path = [grid.index('S')]
while grid[path.last] != 'E'
  path << grid.neighbor_positions(path.last, diagonals: false).find do |npos|
    npos != path[-2] && grid[npos] != '#'
  end
end

pt1 = good_cheats(path, 2, 100)
puts "Part 1: #{pt1}"

pt2 = good_cheats(path, 20, 100)
puts "Part 2: #{pt2}"
