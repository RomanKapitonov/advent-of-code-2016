require 'spec_helper'

RSpec.describe Rotate do
  subject(:rotate) { described_class.new(options) }

  describe '#apply' do
    shared_examples 'rotate' do |initial:, with_options:, should_become:|
      context "with given state" do
        let(:options) { with_options }

        it 'should rotate' do
          expect(rotate.apply(initial)).to eq(should_become)
        end
      end
    end

    include_examples 'rotate',
      initial: Matrix[
        [0, 1, 0],
        [1, 1, 0],
        [0, 0, 0]
      ],
      with_options: { 'axis' => 'column', 'at' => '1', 'by' => '2' },
      should_become: Matrix[
        [0, 1, 0],
        [1, 0, 0],
        [0, 1, 0]
      ]

    include_examples 'rotate',
      initial: Matrix[
        [0, 1, 0],
        [1, 1, 0],
        [0, 0, 0]
      ],
      with_options: { 'axis' => 'row', 'at' => '0', 'by' => '1' },
      should_become: Matrix[
        [0, 0, 1],
        [1, 1, 0],
        [0, 0, 0]
      ]
  end
end
