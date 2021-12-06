#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

# Map point -> number of covering lines
vent_map = Hash.new(0) # default each location to zero

File.readlines(INPUT_FILE).each do |line|
  p1, p2 = line.split('->').map { |point| point.split(',').map(&:to_i) }

  x = [p1[0], p2[0]].sort
  y = [p1[1], p2[1]].sort

  if x[0] == x[1] # horizontal line
    (y[0]..y[1]).each { |y_i| vent_map[[x[0], y_i]] += 1 }
  elsif y[0] == y[1] # vertical line
    (x[0]..x[1]).each { |x_i| vent_map[[x_i, y[0]]] += 1 }
  else # diagonal
    next
  end
end

dangerous_area_count = vent_map.values.count { |lines_count| lines_count >= 2 }
puts dangerous_area_count
