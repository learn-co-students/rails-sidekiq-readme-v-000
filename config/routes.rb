Rails.application.routes.draw do
  resources :customers, only: [:index]
  post 'customers/upload', to: 'customers#upload'
end
