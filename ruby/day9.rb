require_relative './lib/aoc'

def consolidate_checksum(free_spaces, files)
  files.reverse_each.sum do |filepos, filelen, fileind|
    free_spaces.each_with_index do |(freepos, freelen), freeind|
      break if freepos > filepos
      next if freelen < filelen
  
      # found free slot
      if freelen == filelen
        # exact fit
        free_spaces.delete_at(freeind)
      else
        free_spaces[freeind] = [freepos + filelen, freelen - filelen]
      end
  
      filepos = freepos
      break
    end
  
    fileind * filelen * (filelen + filepos * 2 - 1) / 2
  end
end

input = AOC.get_input(9)

# Part 1
files = []
free_spaces = []

pos = 0
input.chars.each_with_index do |len, ci|
  len = len.to_i
  if ci.even? # file
    fi = ci / 2
    files += Array.new(len) {|i| [pos + i, 1, fi]}
  else # free space
    free_spaces += Array.new(len) {|i| [pos + i, 1]}
  end
  pos += len
end
pt1_checksum = consolidate_checksum(free_spaces, files)
puts "Part 1: #{pt1_checksum}"

# Part 2
files = []
free_spaces = []

pos = 0
input.chars.each_with_index do |len, ci|
  len = len.to_i
  if ci.even? # file
    files << [pos, len, ci / 2]
  else # free space
    free_spaces << [pos, len]
  end
  pos += len
end

pt2_checksum = consolidate_checksum(free_spaces, files)
puts "Part 2: #{pt2_checksum}"
