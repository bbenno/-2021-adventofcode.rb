#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

crabs = File.open(INPUT_FILE, &:readline).split(',').map(&:to_i).sort

median = (crabs[crabs.size / 2] + crabs[(crabs.size - 1) / 2]) / 2
spend_fuil = crabs.sum { |n| (n - median).abs }

puts spend_fuil
