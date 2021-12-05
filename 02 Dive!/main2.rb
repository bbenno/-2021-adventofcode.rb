#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

position = { horizontal: 0, depth: 0, aim: 0 }

File.readlines(INPUT_FILE).each do |line|
  command, number = /^(\w+) (\d+)/.match(line.chomp).captures
  number = number.to_i
  case command.chomp
  when /forward/
    position[:horizontal] += number
    position[:depth] += number * position[:aim]
  when /down/
    position[:aim] += number
  when /up/
    position[:aim] -= number
  else
    puts "unknown command '#{command}'"
  end
end

puts position[:horizontal] * position[:depth]
