Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :comments, only: [:index]
  resources :links do
    resources :comments
  end

  root to: "links#index"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
