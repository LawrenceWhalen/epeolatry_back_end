class Api::V1::User::WordsController < ApplicationController
  def index
    word_ids = Glossary.users_words(params[:user_id])
    words = Word.find(word_ids)

    word_with_books = UserWordsFacade.words_with_books(word_ids, params[:user_id])

    render json: WordWithBooksSerializer.new(word_with_books)
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
    book_ids = Glossary.where('word_id = ? AND user_id = ?', word.id, params[:user_id]).pluck(:book_id)
    books = book_ids.map do |book_id|
      BookFacade.create_book_object_with_given_id(book_id)
    end

    render json: BookAndWordSerializer.word_and_book_attributes(word, books)
    end

    # serialize a word object with an attribute that is an array of book objects?

    # binding.pry
  end

  #private
  #def _params
    #params.permit(:)
  #end
