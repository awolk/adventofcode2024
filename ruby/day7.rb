require_relative './lib/aoc'
require_relative './lib/grid'
require_relative './lib/parser'

def can_equal?(total, inputs, allow_concat:)
  if inputs.size == 1
    total == inputs.first
  else
    return true if can_equal?(total - inputs.last, inputs[...-1], allow_concat:)
    return true if ((total % inputs.last == 0) && can_equal?(total / inputs.last, inputs[...-1], allow_concat:))

    return allow_concat &&  ((total - inputs.last) % (10 ** inputs.last.to_s.length) == 0) && can_equal?((total - inputs.last) / (10 ** inputs.last.to_s.length), inputs[...-1], allow_concat:)
  end
end

input = AOC.get_input(7)
# input = AOC.get_example_input(7)

equation_parser = P.seq(P.int, ': ', P.int.delimited(' ')).each_line
equations = equation_parser.parse_all(input)

pt1 = equations.filter_map do |total, inputs|
  total if can_equal?(total, inputs, allow_concat: false)
end.sum
puts "Part 1: #{pt1}"

pt2 = equations.filter_map do |total, inputs|
  total if can_equal?(total, inputs, allow_concat: true)
end.sum
puts "Part 2: #{pt2}"
