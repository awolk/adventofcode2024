require_relative './lib/aoc'
require_relative './lib/parser'

input = AOC.get_input(2)
reports = P.int.delimited(' ').each_line.parse_all(input)

def safe?(report)
  diffs = report.each_cons(2).map {|a, b| a - b}
  return false unless diffs.all?(&:positive?) || diffs.all?(&:negative?)
  diffs.all? {|i| i.abs.between?(1, 3)}
end

pt1 = reports.count {|report| safe?(report)}
puts "Part 1: #{pt1}"

pt2 = reports.count do |report|
  next true if safe?(report)
  (0...report.length).any? do |index|
    safe?(report.values_at(0...index, (index+1)...report.length))
  end
end
puts "Part 2: #{pt2}"
