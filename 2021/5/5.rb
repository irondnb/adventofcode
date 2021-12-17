class Line
  attr_reader :x1, :x2, :y1, :y2, :points

  def initialize(start_point, end_point)
    @x1, @y1 = start_point
    @x2, @y2 = end_point
    @points = draw_points
  end

  def straight?
    x1 == x2 || y1 == y2
  end

  private

  def draw_points
    x_p = x1 > x2 ? x1.downto(x2) : x1.upto(x2)
    y_p = y1 > y2 ? y1.downto(y2) : y1.upto(y2)
    straight? ? [*x_p].product([*y_p]) : [*x_p].zip([*y_p])
  end
end

content = File.read('./input.txt').split("\n")
lines_input = content.map { |line| line.split(' -> ') }.map { |line| line.map { |l| l.split(',').map(&:to_i) } }
all_lines = lines_input.map { |input| Line.new(*input) }
straight_lines = all_lines.select(&:straight?)

puts straight_lines.flat_map(&:points).tally.values.count { |x| x > 1 }
puts all_lines.flat_map(&:points).tally.values.count { |x| x > 1 }