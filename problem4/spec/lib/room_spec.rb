require 'spec_helper'
require 'room'

RSpec.describe Room do
  describe 'rooms' do
    shared_examples 'acts like room' do |raw:, uid:, num:, hashsum:, real:|
      context "for #{raw}" do
        subject(:room) { described_class.new(raw) }

        it 'parses uid' do
          expect(room.uid).to eq(uid)
        end

        it 'parses num' do
          expect(room.num).to eq(num)
        end

        it 'parses hashsum' do
          expect(room.hashsum).to eq(hashsum)
        end

        it "is #{real ? '' : 'not '}real" do
          expect(room.real?).to eq(real)
        end
      end
    end

    include_examples 'acts like room', raw: 'aaaaa-bbb-z-y-x-123[abxyz]', uid: 'aaaaa-bbb-z-y-x', num: 123, hashsum: 'abxyz', real: true
    include_examples 'acts like room', raw: 'a-b-c-d-e-f-g-h-987[abcde]', uid: 'a-b-c-d-e-f-g-h', num: 987, hashsum: 'abcde', real: true
    include_examples 'acts like room', raw: 'not-a-real-room-404[oarel]', uid: 'not-a-real-room', num: 404, hashsum: 'oarel', real: true
    include_examples 'acts like room', raw: 'totally-real-room-200[decoy]', uid: 'totally-real-room', num: 200, hashsum: 'decoy', real: false
  end
end

RSpec.describe Hotel do
  describe '#count_real' do
    subject(:hotel) { described_class.new() }

    it 'should count real rooms' do
      # Answer
      expect(hotel.count_real).to eq(173787)
    end

    it 'decyphers the room' do
      expect(hotel.storage.decypher).to eq('northpole object storage')
    end
  end
end
