require 'move'

class Path
  FILENAME = File.expand_path('input', File.dirname(__FILE__))

  attr_reader :file, :raw_moves, :moves

  def initialize(filename = FILENAME)
    @file = File.open(filename)
  end

  def raw_moves
    @raw_moves ||= file.readline.split(', ')
  end

  def moves
    @moves ||= raw_moves.map { |m| Move.new(m) }
  end
end
