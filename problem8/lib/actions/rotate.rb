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

  class Row < Rotate
    def apply(screen)
      # Matrix is immutable
      mutable = screen.to_a
      mutable[at] = screen.row(at).to_a.rotate(-by)
      Matrix[*mutable]
    end
  end

  class Column < Rotate
    def apply(screen)
      # Matrix is immutable
      mutable = screen.transpose.to_a
      mutable[at] = screen.transpose.row(at).to_a.rotate(-by)
      Matrix[*mutable].transpose
    end
  end

  def apply(screen)
    case axis
    when 'column'
      Column.new(matched).apply(screen)
    when 'row'
      Row.new(matched).apply(screen)
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
