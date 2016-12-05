NUMS = {
  one: { up: :noop, right: :noop, down: :three, left: :noop },
  two: { up: :noop, right: :three, down: :six, left: :noop },
  three: { up: :one, right: :four, down: :seven, left: :two },
  four: { up: :noop, right: :noop, down: :eight, left: :three },
  five: { up: :noop, right: :six, down: :noop, left: :noop },
  six: { up: :two, right: :seven, down: :a, left: :five },
  seven: { up: :three, right: :eight, down: :b, left: :six },
  eight: { up: :four, right: :nine, down: :c, left: :seven },
  nine: { up: :noop, right: :noop, down: :noop, left: :eight },
  a: { up: :six, right: :b, down: :noop, left: :noop },
  b: { up: :seven, right: :c, down: :d, left: :a },
  c: { up: :eight, right: :noop, down: :noop, left: :b },
  d: { up: :b, right: :noop, down: :noop, left: :noop },
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
        num.to_s
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
    puts code.join(' ')
  end

  def instructions
    @instructions ||= File.open(File.expand_path('input', File.dirname(__FILE__)))
  end

  def apply(step)
    @current_state = @current_state.send(step.op)
  end
end
