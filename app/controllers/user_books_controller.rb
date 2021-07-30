class UserBooksController < ApplicationController

  def index
    books = UserBooksFacade.all_books(params[:auth_token])
    render json: BookAndShelfSerializer.new(books)
  end

end