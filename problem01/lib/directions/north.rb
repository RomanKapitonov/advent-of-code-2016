require_relative '../direction'
require_relative 'west'
require_relative 'east'

class North < Direction
  def self.turn_left
    West
  end

  def self.turn_right
    East
  end
end
