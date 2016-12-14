class Move
  MOVE_MAP = {
    'L' => :turn_left,
    'R' => :turn_right
  }.freeze

  attr_reader :raw_move, :direction, :steps

  def initialize(input)
    @raw_move = input
  end

  def direction
    @direction ||= MOVE_MAP[raw_move.chars.first]
  end

  def steps
    @steps ||= raw_move.scan(/\d+/).join('').to_i
  end
end
