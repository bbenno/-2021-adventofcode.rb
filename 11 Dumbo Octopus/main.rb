#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'
GRID_SIZE = 10
STEPS = 100

def local_step(config, flashed, line_id, column_id)
  return flashed if line_id.negative? || line_id >= GRID_SIZE ||
                    column_id.negative? || column_id >= GRID_SIZE ||
                    flashed.include?([line_id, column_id]) ||
                    (config[line_id][column_id] += 1) < 10

  config[line_id][column_id] = 0
  flashed << [line_id, column_id]

  propagate_flash(config, flashed, line_id, column_id)
end

def propagate_flash(config, flashed, line_id, column_id)
  a, b = [line_id, column_id].map { |id| [id - 1, id, id + 1] }
  adjacent = a.product(b) - [[line_id, column_id]]
  adjacent.each { |i, j| local_step(config, flashed, i, j) }

  flashed
end

configuration = File.readlines(INPUT_FILE).map do |line|
  line.strip.chars.map(&:to_i)
end

flash_count = (1..STEPS).map do
  flashed = []
  (0...GRID_SIZE).each do |line_id|
    (0...GRID_SIZE).each do |column_id|
      local_step(configuration, flashed, line_id, column_id)
    end
  end
  flashed.size
end.sum

puts flash_count
