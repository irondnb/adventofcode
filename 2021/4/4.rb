# frozen_string_literal: true

class Bingo
  attr_reader :numbers, :boards

  def initialize(input)
    @numbers = input.first.split(',').map(&:to_i)
    @boards = input[1..-1].map do |board|
      Board.new(board.split("\n"))
    end
  end

  def play
    numbers.each_with_index do |number, index|
      boards.each{ |board| board.mark_number(number) }
      next if index < 4

      if (@winner = winners.first)
        @winning_number = number
        break
      end
    end
  end

  def result
    @winner.unmarked_numbers.sum * @winning_number
  end

  def winners
    boards.map { |board| board if board.check }.compact
  end
end

class Board
  attr_reader :rows

  def initialize(rows)
    @rows = rows.map { |row| row.split(' ').map { |n| Number.new(n.to_i)} }
  end

  def mark_number(number)
    rows.each do |row|
      row.each do |n|
        n.mark! if n.value == number
      end
    end
  end

  def check
    rows.any? { |row| row.all?(&:marked) } || rows.transpose.any? { |row| row.all?(&:marked) }
  end

  def unmarked_numbers
    rows.map { |row| row.map { |n| n.value unless n.marked }}.flatten.compact
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
pp bingo.result
