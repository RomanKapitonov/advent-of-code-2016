require 'spec_helper'

RSpec.describe Triangle do
  describe '#possible?' do
    shared_examples 'check triangle' do |sides:, possible:|
      context "for #{sides}" do
        subject(:triangle) { described_class.new(*sides) }

        it "should be #{possible}" do
          expect(triangle.possible?).to eq(possible)
        end
      end
    end

    include_examples 'check triangle', sides: [605, 656, 369], possible: true
    include_examples 'check triangle', sides: [727, 548, 469], possible: true
    include_examples 'check triangle', sides: [58, 84, 437], possible: false
    include_examples 'check triangle', sides: [674, 524, 68], possible: false
    include_examples 'check triangle', sides: [467, 452, 792], possible: true
    include_examples 'check triangle', sides: [841, 519, 660], possible: true
  end
end

RSpec.describe ByRow do
  describe '#possible' do
    subject(:possible) { described_class.new.possible }

    it 'should return correct result' do
      expect(possible.count).to eq(993)
    end
  end
end

RSpec.describe ByColumn do
  describe '#possible' do
    subject(:possible) { described_class.new.possible }

    it 'should return correct result' do
      expect(possible.count).to eq(1849)
    end
  end
end
