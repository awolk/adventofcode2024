require_relative './lib/aoc'
require_relative './lib/parser'

Machine = Data.define(:ax, :ay, :bx, :by, :px, :py)

machine_parser = P.seq(
  "Button A: X+", P.int, ", Y+", P.int,
  "\nButton B: X+", P.int, ", Y+", P.int,
  "\nPrize: X=", P.int, ", Y=", P.int
).map {|vals| Machine.new(*vals)}
parser = machine_parser.delimited("\n\n")

input = AOC.get_input(13)
# input = AOC.get_example_input(13)
machines = parser.parse_all(input)

pt1 = machines.sum do |m|
  # px = a * ax + b * bx
  # py = a * ay + b * by
  # where minimum a
  
  # b = (py -  a * ay) / by
  # px = a * ax + (py -  a * ay) * bx/by
  # px = a*ax + py*bx/by - a*ay*bx/by
  # a * (ax - ay * bx / by) = px - py*bx/by
  # a = (px - py*bx/by) / (ax - ay * bx / by)
  a = (m.px - m.py * m.bx.to_f / m.by) / (m.ax - m.ay * m.bx.to_f / m.by)
  b = (m.py - a * m.ay) / m.by

  next 0 if (a - a.round).abs > 0.00001 || (b - b.round).abs > 0.00001

  a.round * 3 + b.round
end
puts "Part 1: #{pt1}"

pt2 = machines.sum do |m|
  px = 10000000000000 + m.px.to_f
  py = 10000000000000 + m.py.to_f
  a = (px - py * m.bx.to_f / m.by) / (m.ax - m.ay * m.bx.to_f / m.by)
  b = (py - a * m.ay) / m.by

  # this level of precision seems arbitrary...
  next 0 if (a - a.round).abs > 0.001 || (b - b.round).abs > 0.001

  a.round * 3 + b.round
end
puts "Part 2: #{pt2}"