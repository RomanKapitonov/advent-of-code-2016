require 'spec_helper'
require 'map'
require 'move'

RSpec.describe Map do
  shared_examples 'pointer moves' do |moves:, exp_x:, exp_y:|
    context "for #{moves}" do
      subject(:map) { described_class.new }

      before { moves.map { |rm| Move.new(rm) }.each { |move| map.apply(move) } }

      it 'should move to coordinates' do
        expect(map.x).to eq(exp_x)
        expect(map.y).to eq(exp_y)
      end
    end
  end

  include_examples 'pointer moves', moves: ['R3', 'L3'], exp_x: 3, exp_y: 3
  include_examples 'pointer moves', moves: ['R3', 'R3', 'R3', 'R3'], exp_x: 0, exp_y: 0
  include_examples 'pointer moves', moves: ['R3', 'L3', 'R3', 'L3'], exp_x: 6, exp_y: 6
  include_examples 'pointer moves', moves: ['L3', 'L3', 'R3', 'L3'], exp_x: -6, exp_y: -6

  describe '#final_distance' do
    subject(:map) { described_class.new }

    it 'should walk through the path' do
      # Answer!
      expect(map.final_distance).to eq(209)
    end
  end

  describe '#distance_to_first_intersection' do
    subject(:map) { described_class.new }

    before { map.go! }

    it 'should find distance to first intersection' do
      expect(map.distance_to_first_intersection).to eq(136)
    end
  end
end
