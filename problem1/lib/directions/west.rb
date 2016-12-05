require_relative '../direction'
require_relative 'south'
require_relative 'north'

class West < Direction
  def self.turn_left
    South
  end

  def self.turn_right
    North
  end
end
