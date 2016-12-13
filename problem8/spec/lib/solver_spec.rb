require 'spec_helper'

RSpec.describe Solver do
  describe '#count_filled' do
    subject(:solver) { described_class.new }

    it 'should count filled cells' do
      expect(solver.call).to eq(106)
    end
  end
end
