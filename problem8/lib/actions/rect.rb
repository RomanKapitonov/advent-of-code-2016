# Available matched data:
#  matched[:x]
#  matched[:y]
#
class Rect
  attr_reader :matched

  def initialize(matched)
    @matched = matched
  end

  def apply(screen)
    # Matrix is immutable
    mutable = screen.to_a
    y_size.times do |y|
      x_size.times do |x|
        mutable[y][x] = 1
      end
    end

    Matrix[*mutable]
  end

  def x_size
    matched['x'].to_i
  end

  def y_size
    matched['y'].to_i
  end
end
