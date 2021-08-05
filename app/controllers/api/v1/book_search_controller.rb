class Api::V1::BookSearchController < ApplicationController

  def index
    if params[:search]
      index = pageination(params[:page])
      book_poro = BookFacade.title_search(params[:search], index)
      if book_poro != []
        render json: BookPoroSerializer.new(book_poro)
      else
        render json: { data: [] }
      end
    else
      render json: { error: 'No search sent' }
    end
  end

  def show
    book = BookFacade.create_book_object_with_given_id(params[:book_id])

    render json: BookPoroSerializer.new(book)
  end
end
