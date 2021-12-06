#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'
DAYS = 256

fishes = File.readlines(INPUT_FILE).first.strip.split(',').map(&:to_i).tally

DAYS.times do
  count_new = fishes[0] || 0
  (1..8).each do |days_left|
    fishes[days_left - 1] = fishes[days_left] || 0
    fishes[days_left] = 0
  end
  fishes[6] += count_new
  fishes[8] = count_new
end

puts fishes.values.sum
