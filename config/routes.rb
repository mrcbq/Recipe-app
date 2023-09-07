Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/custom_sign_out" => "devise/sessions#destroy", as: :custom_destroy_user_session
  end
  resources :recipe_foods, only: [ :destroy, :new, :create, :edit, :update ]
  resources :foods, only: [ :index, :new, :create, :destroy ]
  resources :recipes, only: [ :index, :show, :create, :destroy, :new, :update ]

  get '/public_recipes', to: 'recipes#public_recipes'
  get '/general_shopping_list', to: 'foods#general_shopping_list'

  # Defines the root path route ("/")
  root "foods#index"
end
