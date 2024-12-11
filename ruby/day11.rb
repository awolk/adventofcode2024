require_relative './lib/aoc'

def next_counts(counts)
  new_counts = Hash.new {0}
  counts.each do |stone, count|
    if stone == 0
      new_counts[1] += count
    elsif (stone_s = stone.to_s).length.even?
      midway = stone_s.length / 2
      new_counts[stone_s[...midway].to_i] += count
      new_counts[stone_s[midway...].to_i] += count
    else
      new_counts[stone * 2024] += count
    end
  end
  new_counts
end

input = AOC.get_input(11)
stones = input.split.map(&:to_i)
counts = stones.tally

25.times {counts = next_counts(counts)}
pt1 = counts.values.sum
puts "Part 1: #{pt1}"

50.times {counts = next_counts(counts)}
pt2 = counts.values.sum
puts "Part 2: #{pt2}"
