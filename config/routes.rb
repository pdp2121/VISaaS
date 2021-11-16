Rails.application.routes.draw do
  match 'weather/data' => 'weather#data', via: [:get, :post]
  match 'weather/forecast' => 'weather#forecast', via: [:get, :post]
  root "home#index"

  get '/index', to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
