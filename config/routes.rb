Rails.application.routes.draw do
  get 'home/index'
  root  'test#index'
  resources :home do
    collection do
      get :test
    end
  end
end
