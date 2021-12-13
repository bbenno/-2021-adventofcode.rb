#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

def fold!(dots, fold_axis, fold_index)
  map_dots = if fold_axis == :x
               ->(x, y) { x <= fold_index ? [x, y] : [2 * fold_index - x, y] }
             else
               ->(x, y) { y <= fold_index ? [x, y] : [x, 2 * fold_index - y] }
             end
  dots.map! { |x, y| map_dots.call(x, y) }.uniq!
end

dots = []
folds = []

File.readlines(INPUT_FILE).each do |line|
  case line
  when /^(?<x>\d+),(?<y>\d+)$/
    dots << [Regexp.last_match(:x).to_i, Regexp.last_match(:y).to_i]
  when /^fold along (?<axis>[x,y])=(?<idx>\d+)$/
    folds << [Regexp.last_match(:axis).to_sym, Regexp.last_match(:idx).to_i]
  end
end

folds.each { |axis, idx| fold!(dots, axis, idx) }

max_x = dots.map(&:first).max
max_y = dots.map(&:last).max

code = (0..max_y).map do |j|
  (0..max_x).map do |i|
    dots.include?([i, j]) ? '#' : '.'
  end.join
end.join("\n")

puts code
