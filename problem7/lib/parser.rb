# /
# ^
# (            # Group outside square brackets
#   ?=.*       # Positive lookahead
#   (\p{Word}) # First letter
#   (?!\1)     # Should not repeat
#   (\p{Word}) # Second letter
#   \2         # Second letter should be mirrored
#   \1         # First letter should be mirrored
# )
# (            # Brackets group
#   ?!         # Should not be present
#   .*         # Should match everything before brackets
#   \[[^\]]*   # Start with square followed by symbols other than closing bracket
#   (\p{Word}) # First letter
#   (?!\3)     # Should not repeat
#   (\p{Word}) # Second letter
#   \4         # Second letter should be mirrored
#   \3         # First letter should be mirrored
# )
# /
class Line < String
  REGEX = /^(?=.*(\p{Word})(?!\1)(\p{Word})\2\1)(?!.*\[[^\]]*(\p{Word})(?!\3)(\p{Word})\4\3)/.freeze

  def supports_tls?
    self.gsub!("\n", '')
    self =~ REGEX
  end
end

class Parser
  attr_reader :file

  def initialize
    @file = File.open(File.expand_path('../input', __FILE__))
  end

  def count
    file.map { |l| Line.new(l) }.map(&:supports_tls?).compact.count
  end
end
