#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

numbers = File.open(INPUT_FILE, &:readline).split(',').map(&:to_i).sort

median = (numbers[numbers.size / 2] + numbers[(numbers.size - 1) / 2]) / 2
spend_fuil = numbers.sum { |n| (n - median).abs }

puts spend_fuil
