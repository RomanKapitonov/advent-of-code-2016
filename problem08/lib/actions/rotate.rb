# Available matched data:
#  matched[:axis]
#  matched[:direction]
#  matched[:target]
#  matched[:by]
#
class Rotate
  UnknownAxis = Class.new(StandardError)
  attr_reader :matched

  def initialize(matched)
    @matched = matched
  end

  def rotate(screen)
    mutable = screen.to_a
    mutable[at] = screen.row(at).to_a.rotate(-by)
    Matrix[*mutable]
  end

  def apply(screen)
    case axis
    when 'column'
      rotate(screen.transpose).transpose
    when 'row'
      rotate(screen)
    else
      raise UnknownAxis
    end
  end

  def axis
    matched['axis']
  end

  def at
    matched['at'].to_i
  end

  def by
    matched['by'].to_i
  end
end
