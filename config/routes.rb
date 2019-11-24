Rails.application.routes.draw do
  root  'signup#index'
  resources :signup, only: [:index] do
    collection do
      get :login
      get :registration
      get :sms_confirmation
      get :address
      get :card
    end
  end
end
