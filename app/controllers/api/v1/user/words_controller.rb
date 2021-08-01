class Api::V1::User::WordsController < ApplicationController
  def index

  end

  def show

  end

  def new

  end

  def create
    new_word = UserWordsFacade.create_word(params[:word])
    if !new_word.nil?
      Glossary.create(word_id: new_word.id, book_id: params[:volume_id], user_id: params[:user_id])
      render json: { response: 'Created' }, status: :created
    else
      render json: { response: 'Not Found' }, status: :not_found
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  #private
  #def _params
    #params.permit(:)
  #end
end
