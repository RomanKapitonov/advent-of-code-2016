require 'spec_helper'

RSpec.describe Parser do
  describe '#count' do
    subject(:parser) { described_class.new }

    it 'should count matching strings' do
      # Answer
      expect(parser.count).to eq(110)
    end
  end
end
