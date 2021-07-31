class UserBooksController < ApplicationController

  def index
    books = UserBooksFacade.all_books(params[:auth_token])
    render json: BookAndShelfSerializer.new(books)
  end

  def create
    UserBooksFacade.add_book(params[:volume_id], params[:auth_token])
  end

end
