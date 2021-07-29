Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/books/search', to: 'book_search#index'
  get '/words/search', to: 'words#search'
end
