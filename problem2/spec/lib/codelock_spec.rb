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

    include_examples 'moves through nums', initial: :five, step: :up, result: :five
    include_examples 'moves through nums', initial: :five, step: :down, result: :five
    include_examples 'moves through nums', initial: :five, step: :right, result: :six
    include_examples 'moves through nums', initial: :five, step: :left, result: :five

    include_examples 'moves through nums', initial: :one, step: :up, result: :one
    include_examples 'moves through nums', initial: :one, step: :down, result: :three
    include_examples 'moves through nums', initial: :one, step: :right, result: :one
    include_examples 'moves through nums', initial: :one, step: :left, result: :one

    include_examples 'moves through nums', initial: :six, step: :up, result: :two
    include_examples 'moves through nums', initial: :six, step: :down, result: :a
    include_examples 'moves through nums', initial: :six, step: :right, result: :seven
    include_examples 'moves through nums', initial: :six, step: :left, result: :five
  end

  describe '#go!' do
    subject(:codelock) { described_class.new() }

    it 'gives answer' do
      codelock.go! # 74921 - Part 1
                   # A6B35 - Part 2
    end
  end
end


