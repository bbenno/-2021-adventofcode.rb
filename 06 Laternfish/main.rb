#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || File.expand_path('input', __dir__)

DAYS = 80

REPRODUCTION_DURATION = 7
RDI = REPRODUCTION_DURATION - 1 # Index

NEW_BORN_REPRODUCTION_RATE = REPRODUCTION_DURATION + 2
NRDI = NEW_BORN_REPRODUCTION_RATE - 1 # Index

fishes = File.open(INPUT_FILE, &:readline).split(',').map(&:to_i)

DAYS.times do
  count_new = fishes.count(0)
  fishes.map! { |f| f.zero? ? 6 : f - 1 }
  fishes.concat(Array.new(count_new, 8))
end

puts fishes.size
