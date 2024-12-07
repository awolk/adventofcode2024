require_relative './lib/aoc'
require_relative './lib/parser'

def can_equal?(total, inputs, allow_concat:)
  if inputs.size == 1
    return total == inputs.first
  end

  last = inputs.last
  others = inputs[...-1]

  # last operator is addition
  return true if can_equal?(total - last, others, allow_concat:)
  
  # last operator is multiplication
  return true if ((total % last == 0) && can_equal?(total / last, others, allow_concat:))

  if allow_concat
    # concat is multiplication then addition, undo them in reverse
    multiplier = 10 ** (Math.log10(last).floor + 1)
    after_addition = total - last
    return (after_addition % multiplier == 0) && can_equal?(after_addition / multiplier, others, allow_concat:)
  end

  false
end

input = AOC.get_input(7)

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
