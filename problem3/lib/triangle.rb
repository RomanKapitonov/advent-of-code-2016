class Triangle
  attr_reader :a, :b, :c

  def initialize(a, b, c)
    @a = a
    @b = b
    @c = c
  end

  def possible?
    (a + b) > c && (a + c) > b && (b + c) > a
  end
end

file = File.expand_path('input', File.dirname(__FILE__))
result = File.open(file).map do |line|
  line.strip.gsub(/\s+/, ' ').split(' ').map(&:to_i)
end.map do |sides|
  Triangle.new(*sides)
end.select(&:possible?).count

puts result # 993
