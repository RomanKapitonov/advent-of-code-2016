require 'matrix'
require 'action_parser'
require 'actions/rect'
require 'actions/rotate'

class Solver
  DIMENSIONS = { columns: 50, rows: 6 }.freeze

  attr_accessor :parser, :screen

  def initialize
    @parser = ActionParser.new(File.expand_path("../input", __FILE__))
    @screen = Matrix.build(DIMENSIONS[:rows], DIMENSIONS[:columns]) { nil }
  end

  def call
    parser.actions.inject(screen) do |s, action|
      action.apply(s)
    end.to_a.flatten.compact.count
  end
end
