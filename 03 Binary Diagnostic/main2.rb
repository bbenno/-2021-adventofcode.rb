#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

list = File.readlines(INPUT_FILE).map do |line|
  line.strip.split('')
end

def bit_find(l, cmp, i = 0)
  return l.first if l.size <= 1
  return nil unless i < l.first.size

  ratio = l.map { |bits| bits[i] }.map { |bit| bit.to_i * 2 - 1 }.sum
  common_value = cmp.call(ratio) ? '1' : '0'

  bit_find(l.select { |nr| nr[i] == common_value }, cmp, i + 1)
end

oxygen_generator_ratio = bit_find(list, ->(ratio) { ratio >= 0 }).join.to_i(2)
co2_scrubber_ratio = bit_find(list, ->(ratio) { ratio.negative? }).join.to_i(2)

life_support_rating = oxygen_generator_ratio * co2_scrubber_ratio
puts life_support_rating
