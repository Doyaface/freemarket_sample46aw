Rails.application.routes.draw do

  devise_for :users
  root 'items#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :credits, only: %i[index new edit]
  get'/users/create' => 'users#create'
  resources :items
  resources :users,            only: %i[show new] do
    resource  :logouts,        only: %i[show destroy]
    resource  :profiles,       only: %i[new]
    resource  :user_addresses, only: %i[edit create new]
    resource  :credits,        only: %i[show new]
  end
  resource  :deals,          only: %i[new]
end
