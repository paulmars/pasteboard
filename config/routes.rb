Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :user
  devise_scope :user do
    get 'signup', :to => 'devise/registrations#new'
    get 'login', :to => 'devise/sessions#new'
    get 'signout', :to => 'devise/sessions#destroy'
  end

  root 'boards#index'

  post "b", to: "boards#create", as: "boards"

  get "b/:id", to: "boards#show", as: "board"
  delete "b/:id", to: "boards#destroy"

  get "b/:board_id/files", to: "sitefiles#index", as: "sitefiles"
  post "b/:board_id/files", to: "sitefiles#create"

end
