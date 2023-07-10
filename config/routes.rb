Rails.application.routes.draw do
  get 'foods/index'
  get 'foods/show'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "foods#index"
end
