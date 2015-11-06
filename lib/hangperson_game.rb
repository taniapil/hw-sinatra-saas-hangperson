class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    if letter.to_s.empty? or letter =~ /[^[:alpha:]]/
      raise ArgumentError.new("Only alphabetic letters are allowed")
    end
    
    if @word.downcase.include? letter.downcase
      unless @guesses.include? letter.downcase
        @guesses << letter.downcase
        return true
      end
      return false
    else
      unless @wrong_guesses.include? letter.downcase
        @wrong_guesses << letter.downcase
        return true
      end
      return false
    end
  end

  def word_with_guesses
    guessed = ""
    @word.each_char do |c| 
      if @guesses.include? c
        guessed << c
      else
        guessed << '-'
      end
    end
    return guessed
  end
  
  def check_win_or_lose
    @word.each_char do |c|
      if @guesses.include? c
        next
      elsif @wrong_guesses.length >= 7
        return :lose
      else
        return :play
      end
    end
    return :win
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
