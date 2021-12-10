#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

basin_sizes = Hash.new(0)

heightmap = File.readlines(INPUT_FILE).map do |line|
  line.strip.chars.map(&:to_i)
end

n = heightmap.size
m = heightmap.first.size

(0...n).each do |i|
  (0...m).each do |j|
    x = i
    y = j

    next if heightmap[x][y] == 9

    loop do
      if x.positive? && heightmap[x][y] > heightmap[x - 1][y]
        x -= 1
      elsif x < (n - 1) && heightmap[x][y] > heightmap[x + 1][y]
        x += 1
      elsif y.positive? && heightmap[x][y] > heightmap[x][y - 1]
        y -= 1
      elsif y < (m - 1) && heightmap[x][y] > heightmap[x][y + 1]
        y += 1
      else # low point reached
        break
      end
    end

    basin_sizes[[x, y]] += 1
  end
end

result = basin_sizes.values.sort.last(3).inject(:*)
puts result
