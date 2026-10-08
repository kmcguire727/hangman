#!/usr/bin/env ruby

require_relative 'lib/host'

host = HangmanHost.new('bin/google-10000-english-no-swears.txt')
host.welcome
host.word_display_to_user
# Jobs to be done:
# - Tell the user how many incorrect guesses they have left before Hangman
# - Accept a guessed letter from the user without case sensitivity
# - Detect if that letter appears in the secret word
# - If it does, place the letter where it belongs in the display word to guess
# - Track and present the letters already guessed to the user for convenience 
# - Display the Hangman artwork as incorrect guesses happen:
    # Art.strike_1
    # Art.strike_2
    # Art.strike_3
    # Art.strike_4
    # Art.strike_5
    # Art.strike_6
    # Art.game_over
 
# Modules for the program:
#   File input/output
#   Host module 
#   User module
