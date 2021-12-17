# frozen_string_literal: true

content = File.read('./input.txt').split("\n")

class BinaryDiag
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def power_consumption
    "Power Consumption: #{gamma * epsilon}"
  end

  def life_support_rating
    "Life Support Rating: #{oxygen_generator_rating * co2_scrubber_rating}"
  end

  private

  def gamma
    count_bits(input).map do |count|
      max_value(count)
    end.join.to_i(2)
  end

  def epsilon
    count_bits(input).map do |count|
      min_value(count)
    end.join.to_i(2)
  end

  def max_value(counts)
    return 1 if counts[0] == counts[1]

    counts.max_by { |_, v| v }.first
  end

  def min_value(counts)
    return 0 if counts[0] == counts[1]

    counts.min_by { |_, v| v }.first
  end

  def oxygen_generator_rating
    find_rating(input.dup, method(:max_value))
  end

  def co2_scrubber_rating
    find_rating(input.dup, method(:min_value))
  end

  def find_rating(input, bit_criteria)
    range = (0..input.first.length - 1)
    range.each_with_object(input) do |index, result|
      counts = count_bits(result)
      criteria = bit_criteria.call(counts[index])
      result.select! { |number| number[index].to_i == criteria }
    end.first.to_i(2)
  end

  def count_bits(input)
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
puts diag.power_consumption
puts diag.life_support_rating
