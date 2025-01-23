Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :category_option_restrictions
  resources :cart_items
  resources :carts
  resources :item_characteristics
  resources :option_images
  resources :characteristic_options
  resources :characteristics
  resources :item_images
  resources :items

  resources :items do
    collection do
      get 'by_category/:category_id', to: 'items#items_by_category', as: :by_category
    end
  end

  resources :item_characteristics do
    collection do
      get 'by_item/:item_id', to: 'item_characteristics#characteristics_by_item', as: :by_item
    end
  end

  resources :categories
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
