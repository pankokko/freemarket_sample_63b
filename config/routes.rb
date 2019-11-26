Rails.application.routes.draw do
  root  'signup#index'
  get 'homes/index'
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
