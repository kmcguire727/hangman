require_relative '../lib/art'

RSpec.describe Art do

  describe '.puts_art' do
    it 'prints the stage at the given index' do
      expect { Art.puts_art(2) }.to output(Art::STAGES[2]).to_stdout
    end

    it 'prints last artwork given negative index' do
      expect { Art.puts_art(-1) }.to output(Art::STAGES[6]).to_stdout
    end
  end
end