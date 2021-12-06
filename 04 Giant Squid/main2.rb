#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[0] || 'input'

class Board
  attr_reader :lookup, :last_match

  def initialize(board)
    @rows = board
    @columns = board.transpose

    @lookup = board.each_with_index.map do |row, row_id|
      row.each_with_index
         .map { |number, column_id| [number, [row_id, column_id]] }
    end.flatten(1).to_h

    @last_match = nil
    @numbers_processed = 0
  end

  def match(number)
    @numbers_processed += 1
    row_id, column_id = @lookup[number]

    return false unless row_id && column_id # Number is not on bingo card

    @rows[row_id].delete(number)
    @columns[column_id].delete(number)

    @last_match = number

    true
  end

  def play(numbers)
    numbers.each do |number|
      match(number)
      return @numbers_processed if bingo?
    end

    Float::INFINITY # Unable to win
  end

  def bingo?
    @rows.any?(&:empty?) || @columns.any?(&:empty?)
  end

  def sum_unmatched
    @rows.map(&:sum).sum
  end
end

numbers, *boards = *File.readlines(INPUT_FILE).map(&:strip).slice_before(/^\s*$/)

# numbers is an one-element array due to slicing
numbers = numbers.first.split(',').map(&:to_i)

longest_play_duration = Float::INFINITY
score = nil

boards.map { |b| b.drop(1) } # Dispose leading slice separation (blank line)
      .map { |b| b.map { |line| line.split.map(&:to_i) } }
      .each do |board|
  b = Board.new(board)
  play_duration = b.play(numbers)

  next unless play_duration.finite?

  if play_duration > longest_play_duration || longest_play_duration.infinite?
    longest_play_duration = play_duration
    score = b.sum_unmatched * b.last_match
  end
end

puts score
