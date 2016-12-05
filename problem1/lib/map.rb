require 'direction'
require 'directions/north'
require 'directions/east'
require 'directions/west'
require 'directions/south'
require 'path'
require 'path_history'

class Coeff < Struct.new(:coordinate, :coef)
end

class Coordinate < Struct.new(:x, :y)
end

class Map
  DIRECTIONS = [North, East, South, West].freeze

  DIRECTION_COEF_MAP = {
    North => Coeff.new(:y, +1), # y + 1
    East  => Coeff.new(:x, +1), # x + 1
    South => Coeff.new(:y, -1), # y - 1
    West  => Coeff.new(:x, -1)  # x - 1
  }.freeze

  attr_accessor :currect_direction, :x, :y, :history

  def initialize
    @path = Path.new
    @currect_direction = North
    @x, @y = 0, 0
    @history = [Coordinate.new(0, 0)]
  end

  def go!
    Path.new.moves.each do |move|
      self.apply(move)
    end
  end

  def final_distance
    go!
    @x.abs + @y.abs
  end

  def distance_to_first_intersection
    path_history = PathHistory.new(history)
    intersection = path_history.first_intersection

    intersection.x.abs + intersection.y.abs
  end

  def apply(move)
    # change direction
    @currect_direction = @currect_direction.send(move.direction)
    # change coordinates
    direction_coef = DIRECTION_COEF_MAP[currect_direction]

    move.steps.times do
      if direction_coef.coordinate == :x
        @x += direction_coef.coef
      else
        @y += direction_coef.coef
      end

      @history << Coordinate.new(@x, @y)
    end
  end
end
