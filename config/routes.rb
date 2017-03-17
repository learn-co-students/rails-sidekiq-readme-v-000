Rails.application.routes.draw do
  resources :customers, only: [:index]
  post 'customers/upload', to: 'customers#upload'
  get '/clear', to: 'customers#clear_leads'
  root 'customers#index'
end
