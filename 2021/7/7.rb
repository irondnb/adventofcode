input = File.read('./input.txt').split(',').map(&:to_i)
input_range = (input.min..input.max)
gauss_formula = ->(num1, num2) { ((num1 - num2).abs * ((num1 - num2).abs + 1)) / 2 }

part_1 = input_range.map { |num1| input.map { |num2| (num1 - num2).abs }.sum }.min
puts "Part one: #{part_1}"

part_2 = input_range.map { |num1| input.map { |num2| gauss_formula.call(num1, num2) }.sum }.min
puts "Part two: #{part_2}"
