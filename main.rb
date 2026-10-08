#!/usr/bin/env ruby

require_relative 'lib/host'
require_relative 'lib/player'

host = HangmanHost.new('bin/google-10000-english-no-swears.txt')
player = Player.new
host.welcome
host.word_display_to_user
player.guess_log << host.request_guess

# Jobs to be done:
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

# Refactors to think through:
# - Is it possible to load the art into an array so we don't need an long switch-case to print the right visual?
# - Detect if that letter appears in the secret word
# - If it does, place the letter where it belongs in the display word to guess
# - Track and present the letters already guessed to the user for convenience 
# - Display the Hangman artwork as incorrect guesses happen: