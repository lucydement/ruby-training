require './dictonary'

dictionary = Dictionary.new

loop do
	print "Enter a word: "
	word = gets.chomp

	if dictionary.exist?(word)
		puts "that word exists"
	else
		puts "that word doesn't exists"
	end
end