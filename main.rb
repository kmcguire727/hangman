#!/usr/bin/env ruby

require_relative 'lib/host'
require_relative 'lib/player'

host = HangmanHost.new('bin/google-10000-english-no-swears.txt')
player = Player.new
host.welcome

until host.over?
  host.word_display_to_user
  player.guess_log << host.request_guess
  host.guess_correct?(player.guess_log[-1])
end