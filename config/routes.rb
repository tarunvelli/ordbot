Rails.application.routes.draw do

  root :to => "landingpage#index"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :restaurants do
    resources :orders
  end

  post 'webhooks/:user_id', to: 'webhooks#receive'

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
