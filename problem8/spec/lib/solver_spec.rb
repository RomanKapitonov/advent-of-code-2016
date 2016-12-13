require 'spec_helper'

RSpec.describe Solver do
  describe '#count_filled' do
    subject(:solver) { described_class.new }

    it 'should count filled cells' do
      expect(solver.count_filled).to eq(106)
    end

    it 'should render matrix' do
      expect(solver.render_matrix).to eq('CFLELOYFCS')
    end
  end
end
