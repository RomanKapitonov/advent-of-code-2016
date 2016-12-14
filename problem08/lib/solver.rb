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

  def perform
    @result ||= parser.actions.inject(screen) do |s, action|
      action.apply(s)
    end
  end

  def count_filled
    perform.to_a.flatten.compact.count
  end


  #   ##   ####  #     ####  #      ##   #   # ####   ##    ###
  #  #  #  #     #     #     #     #  #  #   # #     #  #  #
  #  #     ###   #     ###   #     #  #   # #  ###   #     #
  #  #     #     #     #     #     #  #    #   #     #      ##
  #  #  #  #     #     #     #     #  #    #   #     #  #     #
  #   ##   #     ####  ####  ####   ##     #   #      ##   ###
  #
  # CFLELOYFCS
  def render_matrix
    puts
    perform.row_vectors.each do |vector|
      vector.each_slice(5) do |slice|
        slice.each do |cell|
          print cell ? '#' : ' '
        end
        print ' '
      end
      puts
    end
    'CFLELOYFCS'
  end
end
