require_relative '../lib/player'

RSpec.describe Player do
  subject(:player) { described_class.new }

  describe '#guess_log' do
    it 'starts empty' do
      expect(player.guess_log).to eq([])
    end

    it 'records guesses in order' do
      player.guess_log << 'a' << 'b'
      expect(player.guess_log).to eq(%w[a b])
    end
  end
end