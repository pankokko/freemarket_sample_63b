Rails.application.routes.draw do
  root  'signup#index'
  resources :signup, only: [:index] do
    collection do
      get :login
      get :registration
    end
  end
end
