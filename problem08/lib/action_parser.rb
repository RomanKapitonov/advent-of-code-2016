# (?<action>rotate|rect)   # Action type
# \s+                      # Whitespace
# (
#   (                      # Either rotation
#     (?<axis>column|row)  # Extract axis
#     \s+                  # Whitespace
#     (?<target>x|y)       # Target
#     =
#     (?<at>\d+)           # At
#     \s+                  # Whitespace
#     by
#     \s+                  # Whitespace
#     (?<by>\d+)           # Rotate by
#   )
#   |                      # Or rect
#   (
#     (?<x>\d+)            # X dimension
#     x                    # by
#     (?<y>\d+)            # Y dimension
#   )
# )
class ActionParser
  UnsupportedAction = Class.new(StandardError)
  ACTION_PARSER = /(?<action>rotate|rect)\s+(((?<axis>column|row)\s+(?<target>x|y)=(?<at>\d+)\s+by\s+(?<by>\d+))|((?<x>\d+)x(?<y>\d+)))/

  attr_reader :file

  def initialize(filepath)
    @file = File.open(filepath)
  end

  def actions
    file.map do |line|
      matched_data = line.match(ACTION_PARSER)
      matched = Hash[matched_data.names.zip(matched_data.captures)]

      case matched['action']
      when 'rect'
        Rect.new(matched)
      when 'rotate'
        Rotate.new(matched)
      else
        raise UnsupportedAction
      end
    end
  end
end
