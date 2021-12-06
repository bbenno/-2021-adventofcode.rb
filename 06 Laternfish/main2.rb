#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

DAYS = 256

REPRODUCTION_DURATION = 7
RDI = REPRODUCTION_DURATION - 1 # Index

NEW_BORN_REPRODUCTION_RATE = REPRODUCTION_DURATION + 2
NRDI = NEW_BORN_REPRODUCTION_RATE - 1 # Index

fishes = File.open(INPUT_FILE, &:readline).split(',').map(&:to_i).tally

DAYS.times do
  count_new = fishes.delete(0) || 0
  fishes.transform_keys! { |k| k - 1 }
  fishes[RDI] = count_new + (fishes[RDI] || 0)
  fishes[NRDI] = count_new
end

puts fishes.values.sum
