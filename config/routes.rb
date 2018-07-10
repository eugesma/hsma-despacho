Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :entry_notes
  get "entry_note/:id", to: "entry_notes#delete", as: "delete_entry_note"
  resources :out_notes
  get "out_note/:id", to: "out_notes#delete", as: "delete_out_note"
  resources :sectors
  get "sector/:id", to: "sectors#delete", as: "delete_sector"
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
