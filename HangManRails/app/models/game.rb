class Game < ActiveRecord::Base
  Words_File_Path = Rails.root.join("app", "assets", "words.txt")
  MAX_LIVES = 9

  has_many :guesses, dependent: :destroy

  before_validation :get_secret_word
  validates :secret_word, presence: true

  def number_lives_left
    MAX_LIVES - (guesses_as_array - word_as_array).length
  end

  def partial_word
    word_as_array.map do |char| 
      if guesses_as_array.include?(char)
        char
      else
        nil 
      end
    end
  end

  def won?
    (word_as_array - guesses_as_array).empty?
  end

  def lost?
    number_lives_left <= 0
  end

  private

  def get_secret_word
    self.secret_word ||= File.read(Words_File_Path).split.sample
  end

  def guesses_as_array
    guesses.map {|guess| guess.letter}
  end

  def word_as_array
    secret_word.chars
  end
end
