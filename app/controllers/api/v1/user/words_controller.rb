class Api::V1::User::WordsController < ApplicationController
  def index

  end

  def show

  end

  def new

  end

  def create
    word_search_response = WordService.search(params[:word])
    new_word = Word.create(word: word_search_response.first[:word],
                           definition: word_search_response.first[:meanings].first[:definitions].first[:definition],
                           phonetic: word_search_response.first[:phonetics].first[:text],
                           phonetic_link: word_search_response.first[:phonetics].first[:audio],
                           part_of_speech: word_search_response.first[:meanings].first[:partOfSpeech],
                           synonyms: word_search_response.first[:meanings].first[:definitions].first[:synonyms],
                           example: word_search_response.first[:meanings].first[:definitions].first[:example])
    Glossary.create(word_id: new_word.id, book_id: params[:volume_id], user_id: params[:user_id])
    render json: { response: 'Created' }, status: :created
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
