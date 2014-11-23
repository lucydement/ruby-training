require './game_logic'
require './display'

game = Game.new
display = Display.new(game)

while game.alive?
  display.print_current_guess

  guess = gets.chomp
  game.check_guess(guess)

  if game.won?
    display.when_correct
    exit
  end
end
display.when_lost