require_relative './lib/aoc'
require_relative './lib/grid'
require_relative './lib/parser'

input = AOC.get_input(9)
# input = AOC.get_example_input(9)

raise 'ends with empty space' unless input.length.odd?

disk = []
total_file_storage = 0
input.chars.each_with_index do |len, ci|
  len = len.to_i
  if ci.even?
    # file
    fi = ci / 2
    disk += Array.new(len, fi)
    total_file_storage += len
  else
    # free space
    disk += Array.new(len, '.')
  end
end

total_score = 0
index_at = 0
while index_at < total_file_storage
  while disk[0] != '.' && index_at < total_file_storage
    total_score += index_at * disk.shift
    index_at += 1
  end
  disk[0] = disk.pop
end

pt1 = total_score
puts "Part 1: #{pt1}"

# Part 2

# map of index -> [pos, len]
files = {}
# list of [pos, len]
free_spaces = []

pos = 0
input.chars.each_with_index do |len, ci|
  len = len.to_i
  if ci.even?
    # file
    fi = ci / 2
    files[fi] = [pos, len]
  else
    # free space
    free_spaces << [pos, len]
  end
  pos += len
end

(files.size - 1).downto(0).each do |fileind|
  filepos, filelen = files[fileind]
  free_spaces.each_with_index do |(freepos, freelen), freeind|
    break if freepos > filepos # only try and move file left
    next if freelen < filelen # doesn't fit

    # found a spot
    files[fileind] = [freepos, filelen]
    if freelen == filelen
      # exact fit
      free_spaces.delete_at(freeind)
    else
      free_spaces[freeind] = [freepos + filelen, freelen - filelen]
    end
    break
  end
end

pt2 = files.sum do |fileind, (filepos, filelen)|
  fileind * (filepos ... filepos + filelen).sum
end
puts "Part 2: #{pt2}"
