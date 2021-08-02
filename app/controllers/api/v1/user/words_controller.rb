class Api::V1::User::WordsController < ApplicationController
  def index
    word_ids = Glossary.users_words(params[:user_id])
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

  def show
    word = Word.find(params[:id])
    books = Glossary.where('word_id = ?', word.id).pluck(:book_id) #need to also add user_id, passed as a param
    books.map do |book|
      # create a method in the bookservice to lookup the volume, grab title and id
      # BookService.volume_lookup (https://www.googleapis.com/books/v1/volumes/volumeId)
      # make book POROS
    end

    # serialize a word object with an attribute that is an array of book objects?

    # binding.pry
  end

  #private
  #def _params
    #params.permit(:)
  #end
end
