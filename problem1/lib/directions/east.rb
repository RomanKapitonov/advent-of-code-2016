require_relative '../direction'
require_relative 'north'
require_relative 'south'

class East < Direction
  def self.turn_left
    North
  end

  def self.turn_right
    South
  end
end
