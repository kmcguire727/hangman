require_relative '../lib/art'

RSpec.describe Art do
  describe 'STAGES' do
    it 'has no duplicate stages' do
      expect(Art::STAGES.uniq.length).to eq(Art::STAGES.length)
    end
  end

  describe '.puts_art' do
    it 'prints the stage at the given index' do
      expect { Art.puts_art(2) }.to output(Art::STAGES[2]).to_stdout
    end
  end
end