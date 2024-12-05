require 'tsort'
require_relative './lib/aoc'
require_relative './lib/parser'

rule_parser = P.seq(P.int, '|', P.int)
update_parser = P.int.delimited(',')
parser = P.seq(rule_parser.each_line, "\n\n", update_parser.each_line)

input = AOC.get_input(5)
rules, updates = parser.parse_all(input)

must_be_before = {}
rules.each do |a, b|
  (must_be_before[a] ||= []) << b
end

ordered, unordered = updates.partition do |update|
  update.each_with_index.all? do |val, index|
    before_val = update[...index]
    (must_be_before.fetch(val, []) & before_val).empty?
  end
end

pt1 = ordered.sum do |update|
  update[update.size / 2]
end
puts "Part 1: #{pt1}"

class Rules
  include TSort
  
  def initialize(must_be_before)
    @must_be_before = must_be_before
  end

  def tsort_each_node(&blk) = @must_be_before.keys.each(&blk)
  def tsort_each_child(n, &blk) = @must_be_before[n]&.each(&blk)
end

pt2 = unordered.sum do |update|
  # only select rules we care about to avoid cycles
  rules = Rules.new(must_be_before.select {|k, _| update.include?(k)})
  sorted = rules.tsort.reverse

  ordered_update = sorted & update
  ordered_update[ordered_update.size / 2]
end
puts "Part 2: #{pt2}"
