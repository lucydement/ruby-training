
class Display
	def initialize(game_logic)
		@game = game_logic
	end

	def print_current_guess
		guesses = @game.correct_guesses
  	current = @game.word.map {|char| guesses.include?(char) ? char : "_"}
  	puts "\n#{current.join(" ")}\n"
  	puts "You have #{@game.lives_left}"
  	puts "Enter next guess: "
	end

	def when_correct
		puts @game.word.join(" ")
		puts "You got it right!"
	end

	def when_lost
		puts "Sorry, you lost. The word was " + @game.word.join(" ")
	end
end
