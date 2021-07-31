class WordsController < ApplicationController
  def search
    word = WordFacade.word_search(params[:q])
    render json: WordPoroSerializer.new(word)
  end
end
