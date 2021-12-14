#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'
STEPS = 40

polymer_template = ''
pair_insertion_rules = []

File.open(INPUT_FILE) do |file|
  polymer_template = file.readline.strip
  file.readline # Ignore blank line
  pair_insertion_rules = file.readlines.map do |line|
    pair, element = line.split('->').map(&:strip)
    [pair, [pair[0] + element, element + pair[1]]]
  end
end

pair_quantity = polymer_template.chars.each_cons(2).map(&:join).tally
pair_quantity.default = 0

STEPS.times do
  next_pair_quantity = pair_quantity.dup
  pair_insertion_rules.each do |pair, next_pairs|
    next_pair_quantity[pair] -= pair_quantity[pair]
    next_pair_quantity[next_pairs[0]] += pair_quantity[pair]
    next_pair_quantity[next_pairs[1]] += pair_quantity[pair]
  end
  pair_quantity = next_pair_quantity
end

element_quantity = Hash.new(0)
pair_quantity.each { |pair, count| element_quantity[pair[1]] += count }
element_quantity[polymer_template[0]] += 1

puts element_quantity.values.max - element_quantity.values.min
