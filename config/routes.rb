Rails.application.routes.draw do
  root  'test#index'
    resources :test, only: [:index,:show]

end
