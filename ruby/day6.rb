require_relative './lib/aoc'
require_relative './lib/grid'

input = AOC.get_input(6)

ROTATE = {
  [-1, 0] => [0, 1],
  [0, 1] => [1, 0],
  [1, 0] => [0, -1],
  [0, -1] => [-1, 0]
}

Guard = Data.define(:r, :c, :dr, :dc) do
  def advance = Guard.new(r + dr, c + dc, dr, dc)
  def rotate = Guard.new(r, c, *ROTATE[[dr, dc]])
  
  def pos = [r, c]
  
  def self.starting_at(pos)
    Guard.new(pos[0], pos[1], -1, 0)
  end
end

def simulate(grid, extra_obstacle)
  guard = Guard.starting_at(grid.index('^'))

  all_guard_positions = Set[]
  all_states = Set[]

  loop do
    if all_states.include?(guard)
      return [all_guard_positions, true]
    end
    all_states << guard
    all_guard_positions << guard.pos

    advanced = guard.advance
    break if !grid.valid_pos?(advanced.pos)

    if grid[advanced.pos] == '#' || advanced.pos == extra_obstacle
      guard = guard.rotate
    else
      guard = advanced
    end
  end

  [all_guard_positions, false]
end

grid = Grid.chars(input)

all_original_positions, looped = simulate(grid, nil)
raise if looped
pt1 = all_original_positions.size
puts "Part 1: #{pt1}"

pt2 = (all_original_positions - Set[grid.index('^')]).each_with_index.count do |pos, ind|
  _, looped = simulate(grid, pos)
  AOC.report_progress(ind, all_original_positions.size - 2, 20)
  looped
end
puts "Part 2: #{pt2}"