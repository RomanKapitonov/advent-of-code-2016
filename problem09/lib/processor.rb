#
# /
# (?<before>[^\(]*) # Get anything before first opening parenthesis
# \(                # Open parenthesis
# (?<length>\d+)    # Capture <length> symbols forward
# x                 #
# (?<count>\d+)     # Repeat <lenght> <count> times
# \)                # Close parenthesis
# (?<rest>.*)       # Get the rest of the string
# /
#
class Processor
  PARSER = /(?<before>[^\(]*)(\((?<length>\d+)x(?<count>\d+)\))?(?<rest>.*)/

  attr_accessor :input

  def initialize(input)
    @input = input
  end

  def count_transformed
    if need_transformation?
      before.length + length * count + Processor.new(rest[length..-1]).count_transformed
    else
      input.length
    end
  end

  def count_fully_transformed
    if need_transformation?
      before.length +
      count * Processor.new(rest[0...length]).count_fully_transformed +
      Processor.new(rest[length..-1]).count_fully_transformed
    else
      input.length
    end
  end

  def matched
    @matched ||= input.match(PARSER)
  end

  def before
    matched['before']
  end

  def count
    matched['count'].to_i
  end

  def length
    matched['length'].to_i
  end

  def rest
    matched['rest']
  end

  def need_transformation?
    length > 0 && count > 0
  end
end
