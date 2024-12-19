require_relative './lib/aoc'
require_relative './lib/parser'

def simulate(program, a)
  b = 0
  c = 0
  ip = 0
  out = []
  while program[ip]
    op = program[ip]
    operand = program[ip+1]
    combo_op_val =
      case operand
      when 0..3
        operand
      when 4
        a
      when 5
        b
      when 6
        c
      end
    
    # execute op
    case op
    when 0 #adv
      a = a >> combo_op_val
    when 1 #bxl
      b = b ^ operand
    when 2 #bst
      b = combo_op_val % 8
    when 3 #jnz
      if a != 0
        ip = operand - 2
      end
    when 4 #bxc
      b = b ^ c
    when 5 #out
      out << combo_op_val % 8
    when 6 #bdv
      b = a >> combo_op_val
    when 7 #cdv
      c = a >> combo_op_val
    end
    ip += 2
  end
  out
end

input = AOC.get_input(17)
parser = P.seq(
  "Register A: ", P.int,
  "\nRegister B: 0\nRegister C: 0\n\nProgram: ",
  P.int.delimited(',')
)
a, program = parser.parse_all(input)

pt1 = simulate(program, a).join(',')
puts "Part 1: #{pt1}"

# Part 2
# 2,4 1,1 7,5 0,3 4,7 1,6 5,5 3,0
# Program (rearranged) simplifies to:
#   out ((A % 8) ^ (A >> ((A % 8) ^ 1))) ^ 7) % 8
#   A = A >> 3
#   goto start if A != 0

# each triad in A corresponds to one output, affected only by more-significant bits
# therefore, start from most-significant bits and work to produce output in reverse
def as_for_output(program, output)
  return [0] if output.empty?

  as_for_output(program, output[1..]).flat_map do |a_for_rest|
    (0..7).filter_map do |triad|
      potential_a = triad + (a_for_rest << 3)
      potential_a if simulate(program, potential_a) == output
    end
  end
end
pt2 = as_for_output(program, program).min
puts "Part 2: #{pt2}"
