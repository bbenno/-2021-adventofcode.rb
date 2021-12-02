#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[1] || 'input'

position = { horizontal: 0, depth: 0 }

File.readlines(INPUT_FILE).each do |line|
  command, number = /^(\w+) (\d+)/.match(line.trim).captures
  number = number.to_i
  case command.chomp
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
