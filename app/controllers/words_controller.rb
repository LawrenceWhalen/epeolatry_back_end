class WordsController < ApplicationController
  def search
    word = WordFacade.word_search(params[:word])
    render json: WordPoroSerializer.new(word)  
  end
end
