require 'constraints/subdomain_constraint'

Rails.application.routes.draw do
  resources :sites
  
  constraints(SubdomainConstraint.new) do
    root 'sites#show', as: :site_root
  end
  
  root "sites#index"
  
end
