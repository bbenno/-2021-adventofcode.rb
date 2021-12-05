#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'
WINDOWS_SIZE = 3

count = File.readlines(INPUT_FILE)
            .map(&:to_i)
            .each_cons(WINDOWS_SIZE)
            .map(&:sum)
            .each_cons(2)
            .count { |x, y| x < y }

puts count
