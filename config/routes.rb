Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users
  resources :foods, only: [:index, :new, :create, :destroy]
  # Defines the root path route ("/")
  # root "foods#index"
  root "home#index"
  resources :recipes do
    member do
      post 'toggle'
    end
    resources :recipe_foods, only: [:new, :create, :update, :destroy] do
      get :modify, on: :member
    end
  end
  resources :public_recipes, only: [:index]
end
