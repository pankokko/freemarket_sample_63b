Rails.application.routes.draw do
  get 'confirmation/index'
  root  'signup#index'
  get 'homes/index'
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
