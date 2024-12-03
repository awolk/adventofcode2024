require_relative './lib/aoc'

input = AOC.get_input(3)

pt1_regex = /mul\((\d+),(\d+)\)/
pt1 = input.scan(pt1_regex).sum {|a, b| a.to_i * b.to_i}
puts "Part 1: #{pt1}"

pt2_regex = /(mul\((\d+),(\d+)\)|do\(\)|don't\(\))/

enabled = true
pt2 = 0
input.scan(pt2_regex) do |instr, a, b|
  if instr == 'do()'
    enabled = true
  elsif instr == "don't()"
    enabled = false
  elsif enabled
    pt2 += a.to_i * b.to_i
  end
end
puts "Part 2: #{pt2}"
