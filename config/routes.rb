Rails.application.routes.draw do
  devise_for :users
  root 'exhibit#index'
  resources :product, only: [:index, :show]
  resources :confirmation, only: [:index]
  resources :homes, only: [:index]

  resources :exhibit, only: [:index, :new, :create,:edit ,:show,:update ,:destroy] do
    member do 
    get :index2
    get :exhibiting
    end 

    collection do 
      get :search 
      get :search_list
    end
  end

  resources :signup, only: [:index, :create] do
    collection do
      get :login
      get :registration
      get :sms_confirmation
      get :address
      get :card
      get :step1
      get :step2
      get :step4
      get :complete
      get :done
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
