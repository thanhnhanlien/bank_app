Rails.application.routes.draw do
  resources :accounts, only: [:index, :create, :show, :new, :edit, :update, :destroy]
  resources :transactions, only: [:index, :create, :show, :new, :edit, :update, :destroy]

  # mount Users::UsersApi => '/api/users'  

  devise_for :users
  root 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
