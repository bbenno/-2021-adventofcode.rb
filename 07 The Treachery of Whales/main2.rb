#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

numbers = File.open(INPUT_FILE, &:readline).split(',').map(&:to_i)

min = numbers.min
max = numbers.max

spend_fuil = (min..max).map do |s|
  numbers.sum { |n| ((n - s).abs + 1) * (n - s).abs / 2 }
end.min

puts spend_fuil
