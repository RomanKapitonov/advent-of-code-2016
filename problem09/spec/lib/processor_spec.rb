require 'spec_helper'

RSpec.describe Processor do
  describe '#count_transformed' do
    shared_examples 'transforms input' do |given:, length:|
      context "given #{given}" do
        subject(:processor) { described_class.new(given) }

        it 'should count' do
          expect(processor.count_transformed).to eq(length)
        end
      end
    end

    include_examples 'transforms input', given: 'ADVENT', length: 6
    include_examples 'transforms input', given: 'A(1x5)BC', length: 7
    include_examples 'transforms input', given: '(3x3)XYZ', length: 9
    include_examples 'transforms input', given: 'A(2x2)BCD(2x2)EFG', length: 11
    include_examples 'transforms input', given: '(6x1)(1x3)A', length: 6
    include_examples 'transforms input', given: 'X(8x2)(3x3)ABCY', length: 18

    shared_examples 'fully transforms input' do |given:, length:|
      context "given #{given}" do
        subject(:processor) { described_class.new(given) }

        it 'should fully count' do
          expect(processor.count_fully_transformed).to eq(length)
        end
      end
    end

    include_examples 'fully transforms input', given: '(3x3)XYZ', length: 9
    include_examples 'fully transforms input', given: 'X(8x2)(3x3)ABCY', length: 20
    include_examples 'fully transforms input', given: '(27x12)(20x12)(13x14)(7x10)(1x12)A', length: 241920
    include_examples 'fully transforms input', given: '(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN', length: 445

    let(:file) { File.open(File.expand_path('../../../lib/input', __FILE__)) }
    subject(:processor) { described_class.new(file.read) }

    it 'should count part 1' do
      expect(processor.count_transformed).to eq(97714)
    end

    it 'should count part 2' do
      expect(processor.count_fully_transformed).to eq(10762972461)
    end
  end
end
