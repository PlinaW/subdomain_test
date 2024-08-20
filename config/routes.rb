require "constraints/subdomain_constraint"

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions", invitations: "users/invitations" }
  resources :home
  resources :sites

  constraints(SubdomainConstraint.new) do
    root "sites#show", as: :site_root
    resources :site_users, only: [ :index, :destory ] do
      collection do
        post :invite
      end
    end
    resources :users, only: [ :show, :edit, :update ]
  end

  root "home#index"
end
