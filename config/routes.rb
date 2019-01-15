Rails.application.routes.draw do
  root 'customers#index'
  resources :customers, only: [:index]
  post 'customers/upload', to: 'customers#upload'
end
