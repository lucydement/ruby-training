module GamesHelper
  def display_word(game)
    word = game.partial_word
    word.map{|char| char ? char : "_"}.join(" ")
  end

  def display_game(game)
    if game.won?
      "You won, the word was #{game.secret_word}."
    elsif game.lost?
      "You lost, the word was #{game.secret_word}."
    else
      "This game is ongoing, you have #{game.number_lives_left} lives left."
    end  
  end
end
