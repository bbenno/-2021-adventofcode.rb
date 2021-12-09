#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

def filter_low_points(heightmap) # rubocop:disable Metrics/AbcSize
  heightmap.map.with_index do |row, row_id|
    cons = row.each_cons(2)
    descend = cons.map { |a, b| a > b }.prepend(true)
    ascend = cons.map { |b, c| b < c }.append(true)

    ascend.zip(descend).map.with_index do |(asc, desc), j|
      [row_id, j] if asc && desc
    end
  end.flatten(1).compact
end

heightmap = File.readlines(INPUT_FILE).map do |line|
  line.strip.split('').map(&:to_i)
end

low_points_row = filter_low_points(heightmap)
low_points_column = filter_low_points(heightmap.transpose)
low_points = (low_points_row & low_points_column.map { |j, i| [i, j] })

sum = low_points.sum { |i, j| 1 + heightmap[i][j] }
puts sum
