Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/books/search', to: 'book_search#index'
  get '/user/books', to: 'user_books#index'
  get '/words/search', to: 'words#search'

  post '/user/books', to: 'user_books#create'
  # delete '/user/books/:id', to: 'user_books#destroy'
end
