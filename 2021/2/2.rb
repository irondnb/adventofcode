# frozen_string_literal: true

INPUT_PATH = '/Users/irondnb/RubymineProjects/adventpuzzles/2/input.txt'.freeze
content = File.read(INPUT_PATH).split("\n")

class PositionCounter
  FORWARD = 'forward'
  UP = 'up'
  DOWN = 'down'

  attr_reader :depth, :horizontal

  def initialize(input)
    @input = input
    @depth = 0
    @horizontal = 0
    @aim = 0
  end

  def count
    @input.each do |command|
      direction, value = command.split
      execute(direction, value.to_i)
    end

    depth * horizontal
  end

  private

  def execute(command, value)
    case command
    when FORWARD
      @horizontal += value
      @depth += (@aim * value)
    when DOWN
      @aim += value
    when UP
      @aim -= value
    end
  end
end

counter = PositionCounter.new(content)
p counter.count