Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end

      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index]
        resources :merchants, only: [:index]
      end

      resources :invoice_items, only: [:index, :show] do
        resources :items, only: [:index, :show]
        resources :invoices, only: [:index, :show]
      end
    end
  end
end
