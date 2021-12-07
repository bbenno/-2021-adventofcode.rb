#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

crabs = File.open(INPUT_FILE, &:readline).split(',').map(&:to_i)

min = crabs.min
max = crabs.max

spend_fuil = (min..max).map do |s|
  crabs.sum { |n| ((n - s).abs + 1) * (n - s).abs / 2 }
end.min

puts spend_fuil
