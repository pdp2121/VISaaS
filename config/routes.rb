Rails.application.routes.draw do
  match 'weather/data' => 'weather#data', via: [:get, :post]
  match 'weather/forecast' => 'weather#forecast', via: [:get, :post]
  post 'weather/data_download' => 'weather#data_download'
  post 'weather/import' => 'weather#import'

  match '/plot' => 'weather#plot', via: [:get, :post]

  get '/index', to: "home#index"
  root "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
