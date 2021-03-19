Rails.application.routes.draw do
  get 'posts/answered' => 'posts#answered'
  resources :reactions
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end
  
  root to: "home#index"
  resources :users do
    resources :notifications, only: :index
  end
  
    resources :posts do
      resources :likes, only: [:create, :destroy]
        resources :answers, shallow: true do
          resources :reactions
  end
end

  resources :users, only: [:show, :edit, :update] do
    get :favorites, on: :collection
  end

  resources :posts, expect: [:index] do
    resource :favorites, only: [:create, :destroy]
  end
end
