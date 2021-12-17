# SLOW

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other_point)
    other_point.x == x && other_point.y == y
  end

  alias eql? ==
end

class Line
  attr_reader :start_point, :end_point, :points

  def initialize(start_point, end_point)
    @start_point = Point.new(*start_point)
    @end_point = Point.new(*end_point)
    @points = init_points
  end

  def find_overlaps(other_line)
    other_line.points.map do |other_point|
      points.select { |point| point == other_point }
    end.flatten
  end

  def init_points
    (@start_point.x..@end_point.x).map do |x|
      (@start_point.y..@end_point.y).map do |y|
        Point.new(x, y)
      end
    end.flatten
  end
end
puts 'Initializing...'
content = File.read('./input.txt').split("\n")
lines_input = content.map { |line| line.split(' -> ') }.map { |line| line.map { |l| l.split(',').map(&:to_i) } }
puts 'Drawing lines..'
lines = lines_input.map { |input| Line.new(*input) }
lines_count = lines.count

result = {}
lines_count.times do |i|
  puts "Process #{i}/#{lines_count}"
  line = lines.pop
  lines.map do |l|
    print '.'
    l.find_overlaps(line).each do |point|
      result[point] ||= 0
      result[point] += 1
    end
  end
end

pp result
pp result.select { |k, v| v > 1 }.count