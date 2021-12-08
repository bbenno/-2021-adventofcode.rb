#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

count = File.readlines(INPUT_FILE).map do |line|
  line.split('|').last.strip.split.count { |w| [2,3,4,7].include?(w.size) }
end.sum

puts count
