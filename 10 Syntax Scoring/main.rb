#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

pairs = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
points = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137 }

score = File.readlines(INPUT_FILE).map do |line|
  stack = []
  corrupt_char = line.strip.chars.each do |char|
    if pairs.keys.include? char
      stack << pairs[char]
    elsif stack.last == char
      stack.pop
    else
      break char
    end
  end
  points[corrupt_char]
end.compact.sum

puts score
