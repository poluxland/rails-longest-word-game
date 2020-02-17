class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def english?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def new
    @grid = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:name]
    @array = @word.chars
    @grid = params[:grid]
    @is = included?(@word, @grid)
    @dictionary = english?(@word)

    if included?(@word.upcase, @grid)
      if english?(@word)
        @message = "Congratulations #{@word} is a valid English word"
      else
        @message = "Sorry but #{@word} does not seem to be a English word..."
      end
    else
      @message = "Sorry but #{@word} can´t be built from #{@grid}"
    end


  end
end
