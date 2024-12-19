require_relative './lib/aoc'
require_relative './lib/parser'

class Designer
  def initialize(patterns)
    @patterns = patterns
    @regex = Regexp.new("^(#{patterns.join('|')})+$")
    @possible_design_count = {}
  end

  def possible?(design) = @regex.match?(design)
  
  def possible_design_count(design)
    return @possible_design_count[design] if @possible_design_count.key?(design)
    count = @patterns.sum do |pattern|
      next 0 unless design.start_with?(pattern)
      next 1 if design == pattern
      possible_design_count(design[(pattern.length)..])
    end
    @possible_design_count[design] = count
  end
end

input = AOC.get_input(19)
parser = P.seq(P.word.delimited(', '), "\n\n", P.word.each_line)
patterns, designs = parser.parse_all(input)
designer = Designer.new(patterns)

pt1 = designs.count {|design| designer.possible?(design)}
puts "Part 1: #{pt1}"

pt2 = designs.sum {|design| designer.possible_design_count(design)}
puts "Part 2: #{pt2}"
