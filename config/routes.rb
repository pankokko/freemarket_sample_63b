Rails.application.routes.draw do
  root  'signup#index'
  resources :signup do
    collection do
      get :test
    end
  end
end
