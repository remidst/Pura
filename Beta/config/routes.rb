Rails.application.routes.draw do


  get 'documents/create'

  get 'documents/destroy'

  resources :projects do
  	resources :messages
  	resources :documents
  	resources :memberships, path: :users, module: :projects
  end

  devise_for :users, :controllers => {registrations: 'registrations'}
  get 'users/' => 'users#index'

  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
