Rails.application.routes.draw do
  devise_for :users
  root "tops#index"
  resources :users, only: [:edit, :update]
  resources :emotions, only: [:index, :show, :new]
  post "/emotions/result", to:"emotions#result"
  resources :playlists do
    resources :adds, only: [:index, :create, :destroy]
  end
end
