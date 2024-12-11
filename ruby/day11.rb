require_relative './lib/aoc'
require_relative './lib/grid'
require_relative './lib/parser'

input = AOC.get_input(11)
# input = AOC.get_example_input(11)
stones = input.split.map(&:to_i)

25.times do
  stones = stones.flat_map do |stone|
    if stone == 0
      [1]
    elsif stone.to_s.length.even?
      midway = stone.to_s.length / 2
      [stone.to_s[...midway].to_i, stone.to_s[midway..].to_i]
    else
      [stone * 2024]
    end
  end
end
pt1 = stones.length
puts "Part 1: #{pt1}"

pt2 = 0
puts "Part 2: #{pt2}"
