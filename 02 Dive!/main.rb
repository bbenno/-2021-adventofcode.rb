#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || File.expand_path('input', __dir__)

position = { horizontal: 0, depth: 0 }

File.readlines(INPUT_FILE).each do |line|
  command, number = /^(\w+) (\d+)/.match(line.strip).captures
  number = number.to_i

  case command
  when /forward/
    position[:horizontal] += number
  when /down/
    position[:depth] += number
  when /up/
    position[:depth] -= number
  else
    puts "unknown command '#{command}'"
  end
end

puts position[:horizontal] * position[:depth]
