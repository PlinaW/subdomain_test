require 'constraints/subdomain_constraint'

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :home
  resources :sites
  
  constraints(SubdomainConstraint.new) do
    root 'sites#show', as: :site_root
  end
  
  root "home#index"
  
end
