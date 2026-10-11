require_relative './art'

class Hangman
  NUM_OF_GUESSES = 7
  MIN_WORD_SIZE = 5
  MAX_WORD_SIZE = 12

  attr_accessor :file_loaded, :secret_word, :word_display, :guesses_left, :guess_log, :game_won

  def initialize(dict_file_path)
    self.game_won = false
    self.guesses_left = NUM_OF_GUESSES
    self.file_loaded = dict_file_path
    self.secret_word = get_secret_word
    self.word_display = config_word_display
    self.guess_log = []
  end

  def welcome
    puts '-------------------'
    puts 'Welcome to Hangman!'
    puts '-------------------'
  end
  
  def get_secret_word
    # Use the file to pull the options we want into memory and then close it
    # rather then pulling in words we can't use and needing to iterate over them 
    choices = []
    f = File.open(self.file_loaded, 'r')
      f.each_with_index do |w, i|
        word = w.chomp
        word.length >= MIN_WORD_SIZE && word.length <= MAX_WORD_SIZE ? choices << word : next
      end
    f.close
    return choices.sample
  end

  def config_word_display
    display = []
    (self.secret_word.length).times do
      display << "_"
    end
    return display
  end

  def word_display_to_user
    puts "\nWord: #{self.word_display.join(' ')}"
  end

  def request_guess
    Art.puts_art(NUM_OF_GUESSES - self.guesses_left - 1) unless NUM_OF_GUESSES == self.guesses_left

    puts "You have #{self.guesses_left} guesses remaining"
    print 'Make your guess: '
    self.guess_log << gets.chomp.downcase
  end

  def guess_correct?(sec_wrd_arr = self.secret_word.split(''),char)
    was_char_found = false

    sec_wrd_arr.each_with_index do |v, i|
      if v == char
        was_char_found = true
        self.word_display[i] = char
      end
    end
    self.guesses_left -= 1 unless was_char_found
  end

  def over?
    if self.word_display.join('') == self.secret_word
      self.game_won = true
      return true
    elsif self.guesses_left <= 0
      return true
    else
      return false
    end
  end

  def win_or_lose
    if self.game_won
      puts "You win!"
    else
      Art.puts_art(-1)
      puts "You lose."
      puts "The word was: #{self.secret_word}"
      print "You guessed: #{self.guess_log}\n"
    end
  end

end