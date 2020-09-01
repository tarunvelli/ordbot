Rails.application.routes.draw do
  # change this
  default_url_options :host => "ordbot.io"

  root :to => "landingpage#index"

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  get '/home', to: 'panel#home', as: 'home'

  resources :restaurants do
    post 'add_user'
    post 'update_user'
    post 'remove_user'
    resources :orders
    resources :items do
      collection do
        post 'bulk_add'
        post 'sample_file'
      end
    end
  end

  post 'restaurants/:restaurant_id/webhook', to: 'webhooks#receive', as: 'restaurant_webhook'
  get 'restaurants/:restaurant_id/menu', to: 'menu#show', as: 'restaurant_menu'

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
