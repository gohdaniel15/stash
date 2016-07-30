Rails.application.routes.draw do
	root 'users#welcome'

	get "/auth/github/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", as: "sign_out"
  get "/signin" => "sessions#new", as: "sign_in"

  resources :users, only: [:welcome, :new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
