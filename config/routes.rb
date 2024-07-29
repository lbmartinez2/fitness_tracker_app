Rails.application.routes.draw do
  resources :exercises
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  devise_for :users

  namespace :api do
    get '/nutrition_facts/:query', to: 'nutrition_facts#index'
    get '/exercise/:query', to: 'exercise#index'
  end
  # Defines the root path route ("/")
   root "home#index"
end
