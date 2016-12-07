require 'spec_helper'
require 'decoder'

RSpec.describe Decoder do
  describe '#decode!' do
    subject(:decoder) { described_class.new }

    it 'should decode part1' do
      # Answer
      expect(decoder.part1).to eq('cyxeoccr')
    end

    it 'should decode part2' do
      # Answer
      expect(decoder.part2).to eq('batwpask')
    end
  end
end
