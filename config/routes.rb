Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users
  resources :foods, only: %i[index destroy]

  # Defines the root path route ("/")
  root "foods#index"
end
