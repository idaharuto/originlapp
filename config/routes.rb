Rails.application.routes.draw do
  resources :relationships, only: [:create, :destroy]
  get 'lectures/index'
  get 'lectures/new'
  devise_for :users
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :posts do
    resources :comments, only: [:create]
    collection do
      get 'search'
    end
  end
end
