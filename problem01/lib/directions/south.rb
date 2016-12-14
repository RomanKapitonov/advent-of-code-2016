require_relative '../direction'
require_relative 'east'
require_relative 'west'

class South < Direction
  def self.turn_left
    East
  end

  def self.turn_right
    West
  end
end
