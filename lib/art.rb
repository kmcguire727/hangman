module Art
  STAGES = [
    <<~'ONE',
    +---+
    |   |
        |
        |
        |
        |
  =========
    ONE
    <<~'TWO',
    +---+
    |   |
    O   |
        |
        |
        |
  =========
    TWO
    <<~'THREE',
    +---+
    |   |
    O   |
    |   |
        |
        |
  =========
    THREE
    <<~'FOUR',
    +---+
    |   |
    O   |
   /|   |
        |
        |
  =========
    FOUR
    <<~'FIVE',
    +---+
    |   |
    O   |
   /|\  |
        |
        |
  =========
    FIVE
    <<~'SIX',
    +---+
    |   |
    O   |
   /|\  |
   /    |
        |
  =========
    SIX
    <<~'SEVEN',
      +---+
      |   |
      O   |
     /|\  |
     / \  |
          |
    =========
    SEVEN
  ].freeze

  def self.puts_art(index)
    puts STAGES[index]
  end
end