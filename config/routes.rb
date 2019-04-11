Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :entry_notes do
    member do
      get 'show_image'
      get 'delete'
      get "edit_pass"
    end
    collection do
      get "new_pass"
    end 
  end
  resources :out_notes do
    member do
      get 'show_image'
      get 'delete'
      get "edit_pass"
    end
    collection do
    get "new_pass"
    end 
  end
  resources :sectors do
    member do
      get 'delete'
    end
  end

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
