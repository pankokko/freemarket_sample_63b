Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 
  root 'signup#index'
  resources :product, only: [:index]
  resources :homelogin, only: [:index]
  resources :confirmation, only: [:index]
  resources :homes, only: [:index]
  resources :exhibit, only: [:index]
  resources :test, only: [:index, :show] do
    collection do 
      get :logout
      get :identification
      get :card
      get :regi_card
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
end
