class Api::V1::User::WordsController < ApplicationController
  def index
    word_ids = Glossary.where('user_id = ?', params[:user_id]).pluck(:word_id)
    words = Word.find(word_ids)
    render json: WordSerializer.new(words)
  end

  def create
    new_word = UserWordsFacade.create_word(params[:word])

    if !new_word.nil?
      new_word.glossaries.create(book_id: params[:volume_id], user_id: params[:user_id])
      render json: { response: 'Created' }, status: :created
    else
      render json: { response: 'Not Found' }, status: :not_found
    end
  end

  #private
  #def _params
    #params.permit(:)
  #end
end
