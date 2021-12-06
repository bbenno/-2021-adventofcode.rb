#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

count = File.readlines(INPUT_FILE)
            .map(&:to_i)
            .each_cons(2)
            .count { |x, y| x < y }
puts count
