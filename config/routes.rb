Rails.application.routes.draw do
	root 'users#welcome'

	get "/auth/github/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", as: "sign_out"
  get "/signin" => "sessions#new", as: "sign_in"

  resources :users, only: [:welcome, :new, :create, :destroy]

  resources :articles, only: [:index, :new]
  post "/articles" => "articles#create", as: "create_article"

  resources :upvotes, only: [:create]
  resources :goals, only: [:new, :create, :update, :index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
