require_relative './lib/aoc'
require_relative './lib/parser'

input = AOC.get_input(1)
parser = P.int.delimited('   ').each_line
pairs = parser.parse_all(input)

left = pairs.map(&:first).sort!
right = pairs.map(&:last).sort!

pt1 = left.zip(right).sum {|a, b| (a - b).abs}
puts "Part 1: #{pt1}"

right_counts = right.tally
pt2 = left.sum {|n| n * right_counts.fetch(n, 0)}
puts "Part 2: #{pt2}"
