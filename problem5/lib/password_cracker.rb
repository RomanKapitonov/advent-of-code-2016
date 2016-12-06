require 'pry'
require 'digest'

class PasswordCracker
  attr_accessor :door_id, :current_offset, :password

  def initialize(door_id = 'wtnhxymk')
    @door_id = door_id
    @current_offset = 0
  end

  def is_number?(string)
    true if Float(string) rescue false
  end

  def hex
    Digest::MD5.hexdigest("#{door_id}#{current_offset}")
  end

  def part1
    password = []
    while password.length < 8
      @current_offset += 1
      password << hex[5] if hex.start_with? '00000'
    end

    password.join
  end

  def part2
    password = Array.new(8)
    while password.any?(&:nil?)
      @current_offset += 1
      if hex.start_with? '00000'
        position, part = hex[5..6].split('')
        next if !is_number?(position)
        next if position.to_i > 7

        password[position.to_i] ||= part
      end
    end

    password.join
  end
end
