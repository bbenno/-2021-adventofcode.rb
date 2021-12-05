#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

bit_ratios = File.readlines(INPUT_FILE).map do |line|
  line.chomp.split('').map { |bit| bit.to_i * 2 - 1 }
end.transpose.map(&:sum)

gamma = bit_ratios.map { |ratio| ratio >= 0 ? '1' : '0' }.join.to_i(2)
epsilon = bit_ratios.map { |ratio| ratio.negative? ? '1' : '0' }.join.to_i(2)

power_consumption = gamma * epsilon
puts power_consumption
