Rails.application.routes.draw do
  match 'weather/data' => 'weather#data', via: [:get, :post]
  match 'weather/forecast' => 'weather#forecast', via: [:get, :post]
  post 'weather/data_download' => 'weather#data_download'
  match 'upload' => 'weather#upload', via: [:get, :post]
  match '/plot' => 'weather#plot', via: [:get, :post]
  match '/worldmap' => 'weather#worldmap', via: [:get]
  match '/usmap' => 'weather#usmap', via: [:get]
  match '/wordcloud' => 'weather#wordcloud', via: [:get]

  get '/index', to: "home#index"
  root "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
