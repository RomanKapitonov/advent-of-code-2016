require 'spec_helper'
require 'password_cracker'

RSpec.describe PasswordCracker do
  subject(:cracker) { described_class.new }

  describe '#part1' do
    it 'cracks first part' do
      expect(cracker.part1).to eq("2414bc77")
    end
  end

  describe '#part2' do
    it 'cracks second part' do
      expect(cracker.part2).to eq("437e60fc")
    end
  end
end
