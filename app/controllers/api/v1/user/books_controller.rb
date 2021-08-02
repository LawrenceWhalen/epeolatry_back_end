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

  def destroy
    BookService.remove_book(params[:shelf_id], params[:id], params[:auth_token])
  end
end
