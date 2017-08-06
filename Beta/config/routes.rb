Rails.application.routes.draw do

  resources :messages, only: [:new, :create, :edit, :update, :destroy]

  resources :projects
  devise_for :users

  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
