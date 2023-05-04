Rails.application.routes.draw do
  root to: 'home#index'
  resources :urls, only: [:create]
  get "/:short_code", to: "urls#show", as: :short

  devise_for :users
end
