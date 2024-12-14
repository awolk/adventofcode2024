require_relative './lib/aoc'
require_relative './lib/grid'
require_relative './lib/parser'

WIDTH = 101
HEIGHT = 103

Robot = Data.define(:pos, :vel) do
  def pos_after(steps)
    x, y = pos + vel * steps
    Grid::Vec2.new(x % WIDTH, y % HEIGHT)
  end
end

vec_p = P.seq(P.int, ',', P.int).map{|a, b| Grid::Vec2.new(a, b)}
robot_parser = P.seq('p=', vec_p, ' v=', vec_p).map {|p, v| Robot.new(p, v)}
parser = robot_parser.each_line

input = AOC.get_input(14)
robots = parser.parse_all(input)

# Part 1
positions = robots.map {|robot| robot.pos_after(100)}

MID_X = WIDTH / 2
MID_Y = HEIGHT / 2
pt1 = positions.select do |(x, y)|
  x != MID_X && y != MID_Y
end.map do |(x, y)|
  [x <=> MID_X, y <=> MID_Y]
end.tally.values.reduce(:*)
puts "Part 1: #{pt1}"

# Part 2
center = Grid::Vec2.new(MID_X, MID_Y)
# minimize distance to center
pt2 = (0..10000).min_by do |steps|
  positions = robots.map {|robot| robot.pos_after(steps)}
  positions.sum {|pos| (pos - center).magnitude}
end
puts "Part 2: #{pt2}"