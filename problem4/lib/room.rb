class HashsumCounter
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def call
    Hash[frequencies].keys.join[0..4]
  end

  def chars
    input.gsub('-', '').chars
  end

  def char_groups
    chars.group_by(&:chr)
  end

  def frequencies
    char_groups.map { |k, v| [k, v.size] }.sort_by { |f| [-f[1], f[0]] }
  end
end

class Room
  PARSER = /(?<uid>[a-zA-Z\-]+)-(?<num>\d+)\[(?<hashsum>\w+)\]/.freeze

  attr_reader :raw_room, :matched

  def initialize(raw_room)
    @matched = raw_room.match(PARSER)
  end

  def decypher
    base = 'a'.ord
    uid.chars.map do |c|
      if c == '-'
        ' '
      else
        (((c.ord - base) + num) % 26 + base).chr
      end
    end.join
  end

  def real?
    hashsum == counted_hashsum
  end

  def uid
    @uid ||= matched[:uid]
  end

  def num
    @num ||= matched[:num].to_i
  end

  def hashsum
    @hashsum ||= matched[:hashsum]
  end

  def counted_hashsum
    @frequencies ||= HashsumCounter.new(uid).call
  end
end

class Hotel
  attr_reader :raw_list, :rooms

  def initialize
    @raw_list = File.open(File.expand_path('input', File.dirname(__FILE__)))
  end

  def rooms
    @rooms ||= raw_list.map { |r| Room.new(r) }
  end

  def count_real
    rooms.select(&:real?).map(&:num).reduce(:+)
  end

  def storage
    rooms.detect { |r| r.decypher == "northpole object storage" }
  end
end
