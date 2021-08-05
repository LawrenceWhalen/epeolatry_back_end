class Api::V1::User::BooksController < ApplicationController

  def index
    books = UserBooksFacade.all_books(params[:auth_token])   # needs a user id and a filter_by(can be default nothing) in the params
    render json: BookAndShelfSerializer.new(books)
    # pagination here will be difficult, going to try and forgo it for the moment
    # needs to add in a conditional in order to ensure that is sorted correctly,
  end

  def create
    UserBooksFacade.add_book(params[:shelf_id], params[:volume_id], params[:auth_token])
  end

  def show
    book = UserBooksFacade.single_book(params[:auth_token], params[:id])
    word_ids = Glossary.where('book_id = ? AND user_id = ?', params[:id], params[:user_id]).pluck(:word_id)

    if word_ids
      words = word_ids.map do |id|
        Word.find(id)
      end
      render json: BookAndWordSerializer.book_show_page_with_word_ids(book, words)
    else
      render json: BookAndWordSerializer.book_show_page_with_no_word_ids(book)
    end
  end

  def destroy
    BookService.remove_book(params[:shelf_id], params[:id], params[:auth_token])
  end
end
