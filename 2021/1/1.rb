def count_increased(collection)
  counter = 0
  collection.each_with_index do |element, index|
    next if index.zero?

    counter += 1 if element > collection[index - 1]
  end
  counter
end

INPUT_PATH = '/Users/irondnb/RubymineProjects/adventpuzzles/1/input.txt'.freeze
content = File.read(INPUT_PATH).split.map(&:to_i)

# part one

puts "Part one result: #{count_increased(content)}"

# part two

sums = []
content[0..-3].each_with_index do |_, index|

  sums << [content[index], content[index + 1], content[index + 2]].sum
end


puts "Part two result: #{count_increased(sums)}"
