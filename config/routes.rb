Rails.application.routes.draw do
  resources :line_items
  resources :carts
  resources :events
  resources :products
  resource :sessions
  resources :welcome
  devise_for :users
  # resource :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root to: "welcome#index"
  # create route for devise user sign in path
  
  # Added below from Stripe tutorial
  root to: "welcome#index"
  #   resources :events
  get "/payments/success", to: "payments#success"
 

end

