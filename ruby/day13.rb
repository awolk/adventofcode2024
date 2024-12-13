require_relative './lib/aoc'
require_relative './lib/parser'

Machine = Data.define(:ax, :ay, :bx, :by, :px, :py) do
  def tokens
    # px = a * ax + b * bx
    # py = a * ay + b * by
    a = (px - py * bx / by) / (ax - ay * bx / by)
    b = (py - a * ay) / by

    return nil if a != a.to_i || b != b.to_i
    (a * 3 + b).to_i
  end

  def corrected_prize = with(px: px + 10000000000000, py: py + 10000000000000)
end

rat_p = P.int.map(&:to_r)
machine_parser = P.seq(
  "Button A: X+", rat_p, ", Y+", rat_p,
  "\nButton B: X+", rat_p, ", Y+", rat_p,
  "\nPrize: X=", rat_p, ", Y=", rat_p
).map {|vals| Machine.new(*vals)}
parser = machine_parser.delimited("\n\n")

input = AOC.get_input(13)
machines = parser.parse_all(input)

pt1 = machines.filter_map(&:tokens).sum
puts "Part 1: #{pt1}"

pt2 = machines.map(&:corrected_prize).filter_map(&:tokens).sum
puts "Part 2: #{pt2}"