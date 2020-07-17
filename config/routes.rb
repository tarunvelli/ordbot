Rails.application.routes.draw do
  # change this
  default_url_options :host => "app.com"

  root :to => "landingpage#index"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :restaurants do
    resources :orders
    resources :items do
      collection do
        post 'parse'
        post 'sample_file'
      end
    end
  end

  post 'restaurants/:restaurant_id/webhook', to: 'webhooks#receive', as: 'restaurant_webhook'
  get 'restaurants/:restaurant_id/menu', to: 'menu#show', as: 'restaurant_menu'

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
