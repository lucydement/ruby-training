class Game
  attr_reader :word
  attr_reader :lives_left

	def initialize
		@word = File.read("words.txt").split.sample.chars
		@lives_left = 8
		@guessed = []
	end

	def alive?
  	@lives_left != 0
	end

	def won?
  	(@word - @guessed).empty?
	end

	def check_guess(guess)
		if !@word.include?(guess)
  		@lives_left -= 1
		end
		@guessed.push(guess)
	end

	def correct_guesses
		@word.map do |char| 
			if @guessed.include?(char)
				char
			end
		end
	end
end