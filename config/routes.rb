Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  root 'exhibit#index'
  
  resources :exhibit, only: [:index, :new, :create,:edit ,:show,:update ,:destroy] do
    resources :comments, only: [:create]
    collection do 
      get :search 
      get :search_list
      get :complex_search
    end
    member do
      get :purchase
    end
  end

  resources :signup, only: [:index, :create] do
    collection do
      get :step1
      get :step2
      get :complete
    end
  end

  resources :address, only: [:create] do
    collection do
      get :step3
    end
  end
  
  resources :users, only: [:show, :edit] do
    member do
      get :logout
      get :selling
      get :sold
      get :identification
      get :card
      get :regi_card
    end
  end
  
  resources :cards, only: [:index, :new, :create, :destroy] do
    member do
      post :pay
    end
    collection do
      get :step4
      get :done
    end
  end
end
