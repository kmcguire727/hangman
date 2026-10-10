require_relative '../lib/host'

RSpec.describe HangmanHost do
  subject(:host) { described_class.new(word_file) }

  # __dir__ makes the path independent of where you run rspec from
  let(:word_file) { File.expand_path('fixtures/words.txt', __dir__) }

  describe '#initialize' do
    it 'starts with 7 guesses' do
      expect(host.guesses_left).to eq(7)
    end
  end

  describe '#get_secret_word' do
    it 'is within the size limits' do
      expect(host.secret_word.length).to be_between(
        HangmanHost::MIN_WORD_SIZE, HangmanHost::MAX_WORD_SIZE
      )
    end

    it 'has no trailing newline' do
      expect(host.secret_word).not_to end_with("\n")
    end
  end

  describe '#config_word_display' do
    it 'has one blank per letter' do
      expect(host.word_display.length).to eq(host.secret_word.chomp.length)
    end

    it 'is all underscores' do
      expect(host.word_display).to all(eq('_'))
    end
  end

  describe '#word_display_to_user' do
    it 'prints the display with spaces between slots' do
      host.word_display = %w[c _ t]
      expect { host.word_display_to_user }.to output("Word: c _ t\n").to_stdout
    end
  end

  describe '#request_guess' do
    before do
      allow(host).to receive(:gets).and_return("A\n")
      allow(host).to receive(:puts)
      allow(host).to receive(:p)
    end

    it 'returns the guess lowercased, without the newline' do
      expect(host.request_guess).to eq('a')
    end

    it 'tells the player how many guesses remain' do
      host.request_guess
      expect(host).to have_received(:puts).with('You have 7 guesses remaining')
    end
  end

  describe '#guess_correct?' do
    it 'detects whether the guess appears in the secret word' do
      host.secret_word = 'development'
      expect {host.guess_correct?('a') }.with(false)
    end
    xit 'reveals the letter in every matching position'
    xit 'shows the player which letters they already guessed'
    xit 'advances the hangman art on each incorrect guess'
  end
end