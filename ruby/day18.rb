require_relative './lib/aoc'
require_relative './lib/grid'
require_relative './lib/parser'

def dist(grid, start, goal)
  visited = Set[]
  to_visit = Set[start]
  dist = 0
  loop do
    next_to_visit = Set[]
    to_visit.each do |visiting|
      return dist if visiting == goal
      next if visited.include?(visiting)
      visited << visiting
      grid.neighbors_with_positions(visiting, diagonals: false).each do |val, npos|
        next_to_visit << npos if val != '#'
      end
    end

    return nil if next_to_visit.empty?
    dist += 1
    to_visit = next_to_visit
  end
end

input = AOC.get_input(18)
pairs = P.int.delimited(',').each_line.parse_all(input)

grid = Grid.with_dimensions(71, 71) {'.'}
pairs[...1024].each do |x, y|
  grid[y, x] = '#'
end
pt1 = dist(grid, [0, 0], [70, 70])
puts "Part 1: #{pt1}"

# Part 2
grid = Grid.with_dimensions(71, 71) {'.'}
pt2, _ = pairs.each_with_index.find do |(x, y), index|
  grid[y, x] = '#'

  dist(grid, [0, 0], [70, 70]).nil?
end
puts "Part 2: #{pt2.join(',')}"
