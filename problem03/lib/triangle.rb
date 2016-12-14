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

class Line
  attr_reader :data

  def initialize(raw_string)
    @data = raw_string.split.map(&:to_i)
  end
end

class Checker
  attr_reader :filename, :file

  def initialize
    @filename = File.expand_path('input', File.dirname(__FILE__))
  end

  def file
    @file ||= File.open(filename)
  end

  def triangles
    @triangles ||= sides.map do |sides|
      Triangle.new(*sides)
    end
  end

  def possible
    triangles.select(&:possible?)
  end
end

class ByRow < Checker
  def sides
    @sides ||= file.map do |line|
      Line.new(line).data
    end
  end
end

class ByColumn < Checker
  def sides
    @sides ||= file.each_slice(3).map do |lines|
      lines.map { |line| Line.new(line).data }.transpose
    end.inject(:+)
  end
end
