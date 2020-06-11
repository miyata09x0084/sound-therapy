Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  resources :users, only: [:index, :edit, :update]
  resources :emotions, only: [:index, :show, :new]
  post "/emotions/result", to:"emotions#result"
  resources :playlists do
    resources :adds, only: [:index, :create, :destroy]
  end
  match 'mailforms/mailform' => 'mailforms#mailform', :via => [:get, :post]
  match 'mailforms/mailform_confirm' => 'mailforms#mailform_confirm', :via => [:get, :post]
end
