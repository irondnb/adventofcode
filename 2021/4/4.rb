# frozen_string_literal: true

require 'set'

class Bingo
  attr_reader :numbers, :boards

  def initialize(input)
    @numbers = input.first.split(',').map(&:to_i)
    @boards = input[1..-1].map do |board|
      Board.new(board.split("\n"))
    end
    @winners = []
  end

  def play
    numbers.each_with_index do |number, index|
      boards.each do |board|
        board.mark_number(number)
      end
      next if index < 4

      unless winners.empty?
        @winners += winners
        winners.each { |w| boards.delete(w) }
      end
    end
  end

  def result
    pp @winners.first.unmarked_numbers.sum * @winners.first.lucky_number
    pp @winners.last.unmarked_numbers.sum * @winners.last.lucky_number
  end

  def winners
    boards.map { |board| board if board.wins? }.compact
  end
end

class Board
  attr_reader :rows, :lucky_number

  def initialize(rows)
    @rows = rows.map { |row| row.split(' ').map { |n| Number.new(n.to_i) } }
    @lucky_number = nil
  end

  def mark_number(number)
    rows.each do |row|
      row.each do |n|
        n.mark! if n.value == number
      end
    end

    @lucky_number = number if marked_line?
  end

  def wins?
    !@lucky_number.nil?
  end

  def unmarked_numbers
    rows.map { |row| row.map { |n| n.value unless n.marked } }.flatten.compact
  end

  private

  def marked_line?
    rows.any? { |row| row.all?(&:marked) } || rows.transpose.any? { |row| row.all?(&:marked) }
  end
end

class Number
  attr_reader :value, :marked

  def initialize(value)
    @value = value
    @marked = false
  end

  def mark!
    @marked = true
  end
end

content = File.read('./input.txt').split("\n\n")
bingo = Bingo.new(content)
bingo.play
bingo.result
