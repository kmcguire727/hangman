#!/usr/bin/env ruby

require_relative 'lib/game'

game = Hangman.new('bin/google-10000-english-no-swears.txt')
game.welcome

until game.over?
  game.word_display_to_user
  game.request_guess
  game.guess_correct?(game.guess_log[-1])
end

game.win_or_lose