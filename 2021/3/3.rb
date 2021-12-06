# frozen_string_literal: true

content = File.read('./input.txt').split("\n")

class BinaryDiag
  attr_reader :input, :bit_counts

  def initialize(input)
    @input = input
    @bit_counts = count_bits
  end

  def gamma
    bit_counts.map do |count|
      count.max_by { |_, v| v }.first
    end.join.to_i(2)
  end

  def epsilon
    bit_counts.map do |count|
      count.min_by { |_, v| v }.first
    end.join.to_i(2)
  end

  private

  def count_bits
    input.each_with_object([]) do |number, counts|
      number.each_char.with_index do |bit, index|
        counts[index] ||= {}
        counts[index][bit.to_i] ||= 0
        counts[index][bit.to_i] += 1
      end
    end
  end
end


diag = BinaryDiag.new(content)
p diag.gamma * diag.epsilon