#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'
DAYS = 80

fishes = File.readlines(INPUT_FILE).first.strip.split(',').map(&:to_i)

DAYS.times do
  count_new = fishes.count(0)
  fishes.map! { |f| f.zero? ? 6 : f - 1 }
  fishes.concat(Array.new(count_new, 8))
end

puts fishes.count
