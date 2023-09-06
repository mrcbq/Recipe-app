Rails.application.routes.draw do
  resources :recipe_foods, only: [ :destroy, :new, :create, :edit, :update ]
  resources :foods, only: [ :index, :new, :create, :destroy ]
  resources :recipes, only: [ :index, :show, :create, :destroy, :new ]
  get '/public_recipes', to: 'recipes#public_recipes'
  get '/general_shopping_list', to: 'foods#general_shopping_list'

  # Defines the root path route ("/")
  root "foods#index"
end
