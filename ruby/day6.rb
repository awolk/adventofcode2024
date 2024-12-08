require_relative './lib/aoc'
require_relative './lib/grid'

input = AOC.get_input(6)

ROTATE = {
  [-1, 0] => [0, 1],
  [0, 1] => [1, 0],
  [1, 0] => [0, -1],
  [0, -1] => [-1, 0]
}

Guard = Data.define(:pos, :dir) do
  def advance = Guard.new(pos + dir, dir)
  def rotate = Guard.new(pos, ROTATE[dir])
end

# returns all guard starts, and whether the guard looped
def simulate(grid, extra_obstacle)
  guard = Guard.new(grid.index('^'), [-1, 0])
  all_states = Set[]

  loop do
    if all_states.include?(guard)
      return [all_states, true]
    end
    all_states << guard

    advanced = guard.advance
    break if !grid.valid_pos?(advanced.pos)

    if grid[advanced.pos] == '#' || advanced.pos == extra_obstacle
      guard = guard.rotate
    else
      guard = advanced
    end
  end

  [all_states, false]
end

grid = Grid.chars(input)

all_original_states, looped = simulate(grid, nil)
raise if looped
all_original_positions = all_original_states.map(&:pos).to_set
pt1 = all_original_positions.size
puts "Part 1: #{pt1}"

pt2 = (all_original_positions - Set[grid.index('^')]).each_with_index.count do |pos, ind|
  _, looped = simulate(grid, pos)
  AOC.report_progress(ind, all_original_positions.size - 2, 20)
  looped
end
puts "Part 2: #{pt2}"