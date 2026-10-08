module Art
  
  def Art.strike_1
    puts <<~'LOGO'   
  +---+
  |   |
      |
      |
      |
      |
=========
    LOGO
  end

  def Art.strike_2
    puts <<~'LOGO'   
  +---+
  |   |
  O   |
      |
      |
      |
=========
    LOGO
  end

  def Art.strike_3
    puts <<~'LOGO'   
  +---+
  |   |
  O   |
  |   |
      |
      |
=========
    LOGO
  end
  def Art.strike_4
    puts <<~'LOGO'   
  +---+
  |   |
  O   |
 /|   |
      |
      |
=========
    LOGO
  end

  def Art.strike_5
    puts <<~'LOGO'   
  +---+
  |   |
  O   |
 /|\  |
      |
      |
=========
    LOGO
  end

  def Art.strike_6
    puts <<~'LOGO'   
  +---+
  |   |
  O   |
 /|\  |
 /    |
      |
=========
    LOGO
  end

  def Art.game_over
    puts <<~'LOGO'   
  ┌───┐
  │   │
  O   │
 /║\  │
 / \  │
      │
══════╧══
    LOGO
  end

end