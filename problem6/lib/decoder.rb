class Column < Array
  attr_reader :values

  def most_frequent
    grouped_list.max_by { |c, group| group.count }.first
  end

  def most_rare
    grouped_list.min_by { |c, group| group.count }.first
  end

  def grouped_list
    group_by(&:chr)
  end
end

class Decoder
  attr_reader :columns

  def initialize
    file = File.open(File.expand_path('../input', __FILE__))
    @columns = Array.new(8) { Column.new }

    file.each do |line|
      line.gsub(/\s/, '').chars.each_with_index do |c, index|
        columns[index] << c
      end
    end
  end

  def part1
    columns.map(&:most_frequent).join
  end

  def part2
    columns.map(&:most_rare).join
  end
end
