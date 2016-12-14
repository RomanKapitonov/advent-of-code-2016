require 'direction'
require 'directions/east'
require 'directions/north'
require 'directions/south'
require 'directions/west'

RSpec.describe Direction do
  shared_examples 'direction moves' do |from:, to:, on:|
    context "for #{from}" do
      subject(:direction) { from }

      it "turns from #{from} to #{to} on #{on}" do
        expect(direction.send(on)).to eq(to)
      end
    end
  end

  include_examples 'direction moves', from: East, to: North, on: :turn_left
  include_examples 'direction moves', from: East, to: South, on: :turn_right

  include_examples 'direction moves', from: North, to: West, on: :turn_left
  include_examples 'direction moves', from: North, to: East, on: :turn_right

  include_examples 'direction moves', from: South, to: East, on: :turn_left
  include_examples 'direction moves', from: South, to: West, on: :turn_right

  include_examples 'direction moves', from: West, to: South, on: :turn_left
  include_examples 'direction moves', from: West, to: North, on: :turn_right
end
