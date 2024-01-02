Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # devise_for :users
  devise_for :users, sign_out_via: [:get, :delete]
  # Defines the root path route ("/")
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments,  only: [:new, :create]
      resources :likes,  only: [:create] 
    end
  end
end
