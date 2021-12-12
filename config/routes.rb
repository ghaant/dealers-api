Rails.application.routes.draw do
  get '/sync_data', to: 'dealers#sync_data'
  get '/index', to: 'dealers#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
