#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

def count_paths(edges, visited, current, joker = nil)
  return 1 if current == :end

  visited << current unless /[[:upper:]]/.match current
  edges[current].map do |n|
    if visited.include?(n)
      count_paths(edges, visited.dup, n, n) if joker.nil? && n != :start
    else
      count_paths(edges, visited.dup, n, joker)
    end
  end.compact.sum
end

edges = {}
File.readlines(INPUT_FILE).each do |line|
  a, b = line.strip.split('-').map(&:to_sym)
  (edges[a] ||= []) << b
  (edges[b] ||= []) << a
end

count = count_paths(edges, [], :start)
puts count
