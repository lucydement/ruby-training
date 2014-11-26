class Game < ActiveRecord::Base
  WORDS_FILE_PATH = Rails.root.join("app", "assets", "words.txt")
  MAX_LIVES = 9

  has_many :guesses, dependent: :destroy

  before_validation :generate_secret_word
  validates :secret_word, presence: true

  def number_lives_left
    MAX_LIVES - (guessed_letters - secret_letters).length
  end

  def partial_word
    secret_letters.map do |char| 
      if guessed_letters.include?(char)
        char
      end
    end
  end

  def won?
    (secret_letters - guessed_letters).empty?
  end

  def lost?
    number_lives_left <= 0
  end

  private

  def generate_secret_word
    self.secret_word ||= File.read(WORDS_FILE_PATH).split.sample
  end

  def guessed_letters
    guesses.map {|guess| guess.letter}
  end

  def secret_letters
    secret_word.chars
  end
end
