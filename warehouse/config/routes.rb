Rails.application.routes.draw do
  root "customers#index"

  get "/index", to: "customers#index"
end
