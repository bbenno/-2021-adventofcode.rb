#! /usr/bin/env ruby
# frozen_string_literal: true

INPUT_FILE = ARGV[1] || 'input'

class Board
  attr_reader :lookup, :last_move

  def initialize(board)
    @rows = board
    @columns = board.transpose

    @lookup = board.each_with_index.map do |row, row_id|
      row.each_with_index.map { |value, column_id| [value, [row_id, column_id]] }
    end.flatten(1).to_h

    @last_move = nil
    @moves_processed = 0
  end

  def move(number)
    @moves_processed += 1
    i, j = @lookup[number]

    return unless i && j

    @rows[i].delete(number)
    @columns[j].delete(number)

    @last_move = number
  end

  def play(numbers, timeout = -1)
    numbers.each do |number|
      move(number)
      return @moves_processed if won?

      break if timeout.positive? && @moves_processed >= timeout
    end

    -1 # Unable to win
  end

  def won?
    @rows.any?(&:empty?) || @columns.any?(&:empty?)
  end

  def sum_unmarked
    @rows.map(&:sum).sum
  end
end

moves, *boards = *File.readlines(INPUT_FILE).map(&:strip).slice_before(/^\s*$/)

# Unwrap moves
moves = moves.first.split(',').map(&:to_i)

shortest_count_moves = moves.count + 1
score = nil

boards.map { |b| b.drop(1) } # Dispose leading slice separation (blank line)
  .map { |b| b.map { |l| l.split.map(&:to_i) } }
  .each do |board|
  b = Board.new(board)

  count_moves = b.play(moves, shortest_count_moves)

  if count_moves.positive? && count_moves < shortest_count_moves
    shortest_count_moves = count_moves
    score = b.sum_unmarked * b.last_move
  end
end

puts score
