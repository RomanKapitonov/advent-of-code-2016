require 'spec_helper'
require 'move'

RSpec.describe Move do
  shared_examples 'behaves like move' do |rule:, direction:, steps:|
    context "for #{rule}" do
      subject(:move) { described_class.new(rule) }

      it 'should set direction' do
        expect(move.direction).to eq(direction)
      end

      it 'should set steps' do
        expect(move.steps).to eq(steps)
      end
    end
  end

  include_examples 'behaves like move', rule: 'R44', direction: :turn_right, steps: 44
  include_examples 'behaves like move', rule: 'L2', direction: :turn_left, steps: 2
end
