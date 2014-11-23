class Dictionary
	def initialize
		@words == File.read("words.txt").split
	end

	def exists?(word)
		@words.include?(word)
	end	
end