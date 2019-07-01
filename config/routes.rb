Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_items', to: 'most_items#index'
        get '/most_revenue', to: 'most_revenue#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index]
        resources :merchants, only: [:index]
      end

      namespace :item_invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      resources :invoice_items, only: [:index, :show] do
        resources :items, only: [:index, :show]
        resources :invoices, only: [:index, :show]
      end
    end
  end
end
