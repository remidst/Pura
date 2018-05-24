Rails.application.routes.draw do

  get 'reportings/create'

  get 'reportings/update'

  get 'reportings/delete'

  #schedule routes
  constraints subdomain: 'schedule' do
    resources :schedules, only: [:new, :show, :create, :index, :edit, :destroy]
  end

  resources :projects do
  	resources :memberships, only: [:new, :create, :index, :destroy]
    resources :specs, only: [:create, :show, :edit, :update]
    resources :publications, only: [:create, :edit, :update, :destroy]
  end

  resources :publications do 
    resources :publication_comments, only: [:create]
    member do 
      patch :toggle_read_publication
    end
    resources :publication_attachments, only: [:create, :destroy]
  end

  resources :contacts do 
    resources :reportings do 
      resources :reporting_attachments
    end
  end

  resources :reportings do 
    member do 
      patch :toggle_read_reporting
    end
    resources :reporting_attachments, only: [:create, :destroy]
  end


  resources :timelines, only: [:index]

  #custom route to download spec
  get 'spec/:id/download' => 'download#show', as: :spec_download

  #custom routes for projects

  get 'project/:id/invite_members' => 'projects#invite_members', as: :project_invite_members
  patch 'project/:id/invite_members' => 'projects#update_members', as: :project_update_members

  post 'project/:id/memberships/update_members' => 'memberships#update_members', as: :membership_update_members

  get 'project/:id/edit_leader' => 'projects#edit_leader', as: :project_edit_leader
  patch 'project/:id/edit_leader' => 'projects#update_leader', as: :project_update_leader

  #custom routes for devise, user lookup

  devise_for :users, controllers: {registrations: 'registrations', invitations: 'invitations', sessions: 'sessions'}
  get 'users/' => 'users#index'

  #custom routes for contact reportings, for double-step confirmation

  get 'contact/:contact_id/reporting/:id/confirm' => 'reportings#confirm', as: :contact_reporting_confirm
  patch 'contact/:contact_id/reporting/:id/toggle_confirm' => 'reportings#toggle_confirm', as: :contact_reporting_toggle_confirm

  get 'users/company_lookup' => 'users#company_lookup'
  

  root 'timelines#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
