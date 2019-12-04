Rails.application.routes.draw do
  devise_for :users
  root 'exhibit#index'
  resources :product, only: [:index]
  resources :confirmation, only: [:index]
  resources :homes, only: [:index]
<<<<<<< Updated upstream
  resources :exhibit, only: [:index, :new,:create] do 
=======

  resources :exhibit, only: [:index, :new, :create,:edit,:update, :show] do 
>>>>>>> Stashed changes
    collection do 
      get :search 
      get :search_list
    end
  end

  resources :signup, only: [:index] do
    collection do
      get :login
      get :registration
      get :sms_confirmation
      get :address
      get :card
      get :complete
    
    end
  end
  resources :users, only: [:show, :edit] do
    member do
      get :logout
      get :selling
      get :identification
      get :card
      get :regi_card
    end
  end
  resources :cards, only: [:index, :new, :create, :destroy]
end
