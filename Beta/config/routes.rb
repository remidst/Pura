Rails.application.routes.draw do

  resources :projects do
  	resources :messages
  	resources :documents
  	resources :memberships
  end

  get 'project/:id/edit_leader' => 'projects#edit_leader', as: :project_edit_leader
  patch 'project/:id/edit_leader' => 'projects#update_leader', as: :project_update_leader

  devise_for :users, controllers: {registrations: 'registrations', invitations: 'invitations'}
  get 'users/' => 'users#index'

  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
