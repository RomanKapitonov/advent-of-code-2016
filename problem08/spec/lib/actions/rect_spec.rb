require 'spec_helper'

RSpec.describe Rect do
  let(:matrix) { Matrix.build(5, 5) { 0 } }

  subject(:rect) { described_class.new(options) }

  describe '#apply' do
    context 'fill full' do
      let(:options) do
        {
          'x' => 5,
          'y' => 5
        }
      end

      it 'should build new matrix fully filled' do
        expect(rect.apply(matrix)).to eq(Matrix.build(5, 5) { 1 })
      end
    end

    context 'partially filled' do
      context 'with square' do
        let(:options) do
          {
            'x' => 3,
            'y' => 3
          }
        end

        let(:expected_result) do
          Matrix[
            [1, 1, 1, 0, 0],
            [1, 1, 1, 0, 0],
            [1, 1, 1, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ]
        end

        it 'should build new matrix partially filled' do
          expect(rect.apply(matrix)).to eq(expected_result)
        end
      end

      context 'with rectangle' do
        let(:options) do
          {
            'x' => 3,
            'y' => 1
          }
        end

        let(:expected_result) do
          Matrix[
            [1, 1, 1, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ]
        end

        it 'should build new matrix partially filled' do
          expect(rect.apply(matrix)).to eq(expected_result)
        end
      end
    end
  end
end
