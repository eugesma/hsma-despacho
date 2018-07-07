Rails.application.routes.draw do
  resources :out_notes
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :entry_notes
  resources :sectors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  namespace :charts do
    get "by-day-entry-notes"
    get "by-month-entry-notes"

    get "by-day-out-notes"
    get "by-month-out-notes"

    get "by-sector-entry-notes"
    get "by-sector-out-notes"
  end
end
