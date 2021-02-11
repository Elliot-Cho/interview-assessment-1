Rails.application.routes.draw do
  root 'customers#index'

  resources :customers do
    resources :items

    post :quote_from_input, on: :member
  end
end
