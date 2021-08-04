Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/book/search', to: 'book_search#index'
      get '/book/show', to: 'book_search#show'
      get '/word/search', to: 'word_search#index'
      namespace :user do
        resources :books, only: [:index, :create, :destroy]
        resources :words, only: [:index, :create, :show]
        get '/dashboard', to: 'dashboard#show'
      end
    end
  end
end
