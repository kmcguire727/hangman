require 'tmpdir'
require 'fileutils'
require 'yaml'

require_relative '../lib/game'

RSpec.describe Hangman do
  subject(:game) { described_class.new(word_file) }

  let(:word_file) { File.expand_path('fixtures/words.txt', __dir__) }

  let(:save_dir)  { Dir.mktmpdir }
  let(:save_file) { File.join(save_dir, 'save.yml') }

  before { game.save_path = save_dir }
  after  { FileUtils.remove_entry(save_dir) }

  describe '#initialize' do
    it 'starts with 7 guesses' do
      expect(game.guesses_left).to eq(7)
    end
  end

  describe '#save_game' do
    it 'writes the game to the save file as YAML' do
      game.secret_word = 'apple'
      game.save_game
      expect(File.read(save_file)).to include('secret_word: apple')    end
  end

  describe '#check_for_save' do
    it 'detects save file' do
      
    end

    it 'asks user to load save' do
      
    end
  end

  describe '#load_save' do
    it 'successfully loads saved state' do
      
    end
  end

  describe '#get_secret_word' do
    it 'is within the size limits' do
      expect(game.secret_word.length).to be_between(
        Hangman::MIN_WORD_SIZE, Hangman::MAX_WORD_SIZE
      )
    end

    it 'has no trailing newline' do
      expect(game.secret_word).not_to end_with("\n")
    end
  end

  describe '#config_word_display' do
    it 'has one blank per letter' do
      expect(game.word_display.length).to eq(game.secret_word.chomp.length)
    end

    it 'is all underscores' do
      expect(game.word_display).to all(eq('_'))
    end
  end

  describe '#word_display_to_user' do
    it 'prints the display with spaces between slots' do
      game.word_display = %w[c _ t]
      expect { game.word_display_to_user }.to output("\nWord: c _ t\n").to_stdout
    end
  end

  describe '#request_guess' do
    before do
      allow(game).to receive(:gets).and_return("A\n")
      allow(game).to receive(:puts)
      allow(game).to receive(:print)
      allow(Art).to receive(:puts_art)
    end

    it 'logs the guess lowercased, without the newline' do
      game.request_guess
      expect(game.guess_log).to eq(['a'])
    end

    it 'tells the player how many guesses remain' do
      game.request_guess
      expect(game).to have_received(:puts).with('You have 7 guesses remaining')
    end

    describe 'hangman art' do
      it 'is not shown before any wrong guesses' do
        game.request_guess
        expect(Art).not_to have_received(:puts_art)
      end

      it 'is shown once a guess has been lost' do
        game.guesses_left = described_class::NUM_OF_GUESSES - 1
        game.request_guess
        expect(Art).to have_received(:puts_art).with(0)
      end
    end
  end

  describe '#guess_correct?' do
    before do
      game.secret_word = 'apple'
      game.word_display = %w[_ _ _ _ _]
    end

    context 'when the letter is in the word' do
      it 'reveals it in every matching position' do
        game.guess_correct?('p')
        expect(game.word_display).to eq(%w[_ p p _ _])
      end

      it 'does not cost a guess' do
        expect { game.guess_correct?('p') }.not_to change(game, :guesses_left)
      end
    end

    context 'when the letter is not in the word' do
      it 'leaves the display untouched' do
        game.guess_correct?('z')
        expect(game.word_display).to eq(%w[_ _ _ _ _])
      end

      it 'costs exactly one guess' do
        expect { game.guess_correct?('z') }.to change(game, :guesses_left).by(-1)
      end
    end
  end

  describe '#over?' do
    before do
      game.secret_word = 'apple'
      game.word_display = %w[_ _ _ _ _]
    end

    it 'is true and marks the game won when the word is fully revealed' do
      game.word_display = %w[a p p l e]
      expect(game.over?).to eq(true)
      expect(game.game_won).to eq(true)
    end

    it 'is true but not won when guesses run out' do
      game.guesses_left = 0
      expect(game.over?).to eq(true)
      expect(game.game_won).to be_falsey
    end

    it 'is false while the game is still going' do
      expect(game.over?).to eq(false)
    end
  end

  describe '#win_or_lose' do
    before { allow(Art).to receive(:puts_art) }

    it 'congratulates the player on a win' do
      game.game_won = true
      expect { game.win_or_lose }.to output("You win!\n").to_stdout
    end

    context 'on a loss' do
      before do
        game.game_won = false
        game.secret_word = 'apple'
        game.guess_log = %w[a z]
      end

      it 'reveals the secret word' do
        expect { game.win_or_lose }.to output(/The word was: apple/).to_stdout
      end

      it 'lists the letters guessed' do
        expect { game.win_or_lose }.to output(/You guessed: \["a", "z"\]/).to_stdout
      end

      it 'draws the final hangman stage' do
        game.win_or_lose
        expect(Art).to have_received(:puts_art).with(-1)
      end
    end
  end

end