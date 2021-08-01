class Api::V1::WordSearchController < ApplicationController
  def index
    word = WordFacade.word_search(params[:q])
    render json: WordPoroSerializer.new(word)
  end
end
