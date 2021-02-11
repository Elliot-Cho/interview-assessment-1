Rails.application.routes.draw do
  root 'customers#index'

  resources :customers do
    resources :items
    resources :discounts

    post :quote_from_input, on: :member
  end
end
