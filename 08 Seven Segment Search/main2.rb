#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

sum = File.readlines(INPUT_FILE).map do |line|
  input, output = line.split('|').map do |part|
    part.strip.split.map { |v| v.chars.map(&:to_sym) }
  end

  input.sort_by!(&:size)
  one_segments = input[0]
  four_segments = input[2]

  output.map do |w|
    case w.size
    when 2 then 1
    when 3 then 7
    when 4 then 4
    when 5
      if (one_segments - w).empty? then 3
      elsif (w - four_segments).size == 2 then 5
      else 2 # rubocop:disable Lint/ElseLayout
      end
    when 6
      if (four_segments - w).empty? then 9
      elsif (one_segments - w).empty? then 0
      else 6 # rubocop:disable Lint/ElseLayout
      end
    when 7 then 8
    end
  end.join.to_i
end.sum

puts sum
