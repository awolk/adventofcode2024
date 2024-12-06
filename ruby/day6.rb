require_relative './lib/aoc'
require_relative './lib/grid'

input = AOC.get_input(6)
# input = AOC.get_example_input(6)

ROTATE = {
  [-1, 0] => [0, 1],
  [0, 1] => [1, 0],
  [1, 0] => [0, -1],
  [0, -1] => [-1, 0]
}

def advance((gr, gc), (dr, dc))
  [gr + dr, gc + dc]
end

def simulate(grid, extra_obstacle)
  guard_pos = grid.index('^')
  guard_dir = [-1, 0]

  all_guard_positions = Set[]
  all_states = Set[]

  loop do
    state = [guard_pos, guard_dir]
    if all_states.include?(state)
      return [all_guard_positions, true]
    end
    all_states << state

    all_guard_positions << guard_pos

    new_guard_pos = advance(guard_pos, guard_dir)
    break if !grid.valid_pos?(new_guard_pos)

    if grid[new_guard_pos] == '#' || new_guard_pos == extra_obstacle
      guard_dir = ROTATE[guard_dir]
    else
      guard_pos = new_guard_pos
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