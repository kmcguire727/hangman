require_relative './art'

class HangmanHost
  MIN_WORD_SIZE = 5
  MAX_WORD_SIZE = 12

  attr_accessor :choices, :file_path, :secret_word, :word_display, :guesses_left

  def initialize(dict_file_path)
    self.guesses_left = 7
    self.file_path = dict_file_path
    self.choices = []   # this is an intentional choice since it'll be easier to iterate through and map! on guesses
    collect_words
    self.secret_word = self.choices.sample
    self.word_display = config_word_display
  end

  def welcome
    puts '-------------------'
    puts 'Welcome to Hangman!'
    puts '-------------------'
    puts "The word to guess is: #{self.secret_word}"  # For Debug / Verification
  end

  def collect_words
    # Use the file to pull the options we want into memory and then close it
    # rather then pulling in words we can't use and needing to iterate over them 
    f = File.open(self.file_path, 'r')
      f.each_with_index do |w, i|
        w.length > MIN_WORD_SIZE && w.length < MAX_WORD_SIZE ? self.choices << w : next
      end
    f.close
  end

  def config_word_display
    display = []
    # -1 on the length required to prevent bug where array is always +1 the actual length of the word
    (self.secret_word.length - 1).times do
      display << "_"
    end
    return display
  end

  def word_display_to_user
    puts "Word: #{self.word_display.join(' ')}"
  end

  def request_guess
    puts "You have #{self.guesses_left} guesses remaining"
    p 'Make your guess: '
    guess = gets.chomp.downcase
    return guess
  end

end