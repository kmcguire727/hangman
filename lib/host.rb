require_relative './art'

class HangmanHost
  MIN_WORD_SIZE = 5
  MAX_WORD_SIZE = 12

  attr_accessor :choices, :file_path, :secret_word, :word_display, :guesses_left

  def initialize(dict_file_path)
    self.guesses_left = 7
    self.file_path = dict_file_path
    self.choices = []
    collect_words
    self.secret_word = self.choices.sample
    self.word_display = config_word_display
  end

  def welcome
    puts '-------------------'
    puts 'Welcome to Hangman!'
    puts '-------------------'
    puts "The word to guess is: #{self.secret_word}"
  end

  def collect_words
    f = File.open(self.file_path, 'r')
      f.each_with_index do |w, i|
        w.length > MIN_WORD_SIZE && w.length < MAX_WORD_SIZE ? self.choices << w : next
      end
    f.close
  end

  def config_word_display
    display = []
    (self.secret_word.length - 1).times do
      display << "_"
    end
    return display
  end

  def word_display_to_user
    puts "You have #{self.guesses_left} guesses remaining"
    puts "Word: #{self.word_display.join(' ')}"
  end

end