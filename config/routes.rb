Rails.application.routes.draw do

  devise_for :users
  root 'items#index' 
  resources :items, only: [:show, :edit, :new, :create]
  resources :cards, only: [:new, :show, :destroy,:index] do
    collection do
      post 'pay', to: 'cards#pay'
    end
  end

  resources :items do
    resources :buyers, only: [:index] do
      collection do
        get 'complete', to: 'buyers#complete'
        post 'pay', to: 'buyers#pay'
      end
    end
  end

  resources :signup, only: [:index, :create] do
    collection do
      get 'registration'
      get 'sms_confirmation'
      get 'sms_confirmation_sms'
      get 'address'
    end
  end

  resources :mypage, only: [:index] do
    member do
      get 'user_profile'
      get 'credit_card'
      get 'logout'
    end
  end
end
