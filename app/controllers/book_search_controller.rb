class BookSearchController < ApplicationController

  def index
    if params[:search]
      index = pageination(params[:page])
      book_poro = BookFacade.book_search(params[:search], index)
      render jsonapi: book_poro
    else
      render jsonapi_error: { error: 'No search field' }
    end
  end


end