#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

sum = File.readlines(INPUT_FILE) # rubocop:disable Metrics/BlockLength
          .map do |line|
  input, output = line.split('|').map do |part|
    part.strip.split.map { |v| v.split('') }
  end
  input.sort_by!(&:size)

  output.map do |w|
    case w.size
    when 2, 3, 4, 7
      { 2 => 1, 7 => 8, 3 => 7, 4 => 4 }[w.size]
    when 5
      if (input[0] - w).empty?
        3
      elsif (w - input[2]).size == 2
        5
      else
        2
      end
    when 6
      if !(input[0] - w).empty?
        6
      elsif (input[2] - w).empty?
        9
      else
        0
      end
    end
  end.join.to_i
end.sum

puts sum
