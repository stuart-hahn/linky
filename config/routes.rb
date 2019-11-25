Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  
  resources :comments, only: [:index]
  
  resources :communities do
    resources :links, only: [:new, :create, :index]
  end

  resources :links do
    resources :comments, shallow: true
    post :upvote, on: :member
    post :downvote, on: :member
  end

  get '/newest' => 'links#newest'
  get '/my_commented_links' => 'links#my_commented_links'

  root to: "links#index"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
