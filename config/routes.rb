Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#home"
  resources :users
  post 'users/search' => 'users#search'
  resources :books
  post 'books/search' => 'books#search'
  #get 'books/authors' => 'books#authors'
  get 'authors', to: 'books#authors'
  resources :opinions
  get 'login', to: 'sessions#new'
  get 'api/books/json', to: 'books#getJSON'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
