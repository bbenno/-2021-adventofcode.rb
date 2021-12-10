#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

pairs = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
points = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }

scores = File.readlines(INPUT_FILE).map do |line|
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
  stack.map.with_index { |c, i| points[c] * 5**i }.sum unless corrupt_char
end.compact.sort

middle_score = scores.sort[scores.size / 2]
puts middle_score
