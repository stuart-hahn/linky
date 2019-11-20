Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  
  resources :comments, only: [:index]
  
  resources :communities do
    resources :links, only: [:new, :create, :index]
  end

  resources :links do
    resources :comments, only: [:create, :index]
    post :upvote, on: :member
    post :downvote, on: :member
  end

  get '/newest' => 'links#newest'

  root to: "links#index"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
