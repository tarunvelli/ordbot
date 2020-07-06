Rails.application.routes.draw do
  # change this
  default_url_options :host => "app.com"

  root :to => "landingpage#index"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :restaurants do
    resources :orders
    resources :items
  end

  post 'webhooks/:restaurant_id', to: 'webhooks#receive', as: 'restaurant_webhook'

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
