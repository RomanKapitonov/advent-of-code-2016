require 'numbers_in_words'

NUMS = {
  one: { up: :noop, right: :two, down: :four, left: :noop },
  two: { up: :noop, right: :three, down: :five, left: :one },
  three: { up: :noop, right: :noop, down: :six, left: :two },
  four: { up: :one, right: :five, down: :seven, left: :noop },
  five: { up: :two, right: :six, down: :eight, left: :four },
  six: { up: :three, right: :noop, down: :nine, left: :five },
  seven: { up: :four, right: :eight, down: :noop, left: :noop },
  eight: { up: :five, right: :nine, down: :noop, left: :seven },
  nine: { up: :six, right: :noop, down: :noop, left: :eight }
}.freeze

NUMS.each do |num, ops|
  klass = Class.new do
    ops.each do |op, ref|
      define_singleton_method(op) do
        if ref == :noop
          self
        else
          Object.const_get(ref.capitalize)
        end
      end

      define_singleton_method :to_s do
        NumbersInWords.in_numbers(num)
      end
    end
  end

  Object.const_set(num.capitalize, klass)
end

class Step
  attr_reader :op

  def initialize(input)
    @op = case input
    when 'U'
      :up
    when 'R'
      :right
    when 'D'
      :down
    when 'L'
      :left
    end
  end
end

class Codelock
  attr_accessor :current_state, :code

  def initialize
    @current_state = Five
    @code = []
  end

  def go!
    instructions.each do |line|
      line.gsub(/\s/, '').split('').map { |s| Step.new(s) }.each do |step|
        apply(step)
      end
      code << @current_state.to_s
    end
    puts code.join('')
  end

  def instructions
    @instructions ||= File.open(File.expand_path('input', File.dirname(__FILE__)))
  end

  def apply(step)
    @current_state = @current_state.send(step.op)
  end
end
