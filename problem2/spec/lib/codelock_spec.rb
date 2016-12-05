require 'spec_helper'
require 'codelock'

RSpec.describe Codelock do
  describe 'Nums' do
    shared_examples 'moves through nums' do |initial: :five, step:, result:|
      context "for #{initial}" do
        subject(:num) { Object.const_get(initial.capitalize) }

        it 'steps' do
          expect(num.send(step)).to eq(Object.const_get(result.capitalize))
        end
      end
    end

    include_examples 'moves through nums', initial: :five, step: :up, result: :two
    include_examples 'moves through nums', initial: :five, step: :down, result: :eight
    include_examples 'moves through nums', initial: :five, step: :right, result: :six
    include_examples 'moves through nums', initial: :five, step: :left, result: :four

    include_examples 'moves through nums', initial: :one, step: :up, result: :one
    include_examples 'moves through nums', initial: :one, step: :down, result: :four
    include_examples 'moves through nums', initial: :one, step: :right, result: :two
    include_examples 'moves through nums', initial: :one, step: :left, result: :one

    include_examples 'moves through nums', initial: :six, step: :up, result: :three
    include_examples 'moves through nums', initial: :six, step: :down, result: :nine
    include_examples 'moves through nums', initial: :six, step: :right, result: :six
    include_examples 'moves through nums', initial: :six, step: :left, result: :five
  end

  describe '#go!' do
    subject(:codelock) { described_class.new() }

    it 'gives answer' do
      codelock.go! # 74921
    end
  end
end
