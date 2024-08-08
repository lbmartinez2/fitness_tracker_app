Rails.application.routes.draw do
  resources :exercises
  resources :consumptions

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  namespace :api do
    get '/nutrition_facts/:query', to: 'nutrition_facts#index'
    get '/exercise/:query', to: 'exercise#index'
  end

  resources :consumptions
  
  get 'bmr_and_amr/new', to: 'bmr_and_amr#new', as: 'new_bmr_and_amr'
  post 'bmr_and_amr/calculate', to: 'bmr_and_amr#calculate', as: 'calculate_bmr_and_amr'
  get 'bmr_and_amr/show', to: 'bmr_and_amr#show', as: 'show_bmr_and_amr'


  get 'portfolio', to: 'portfolio#index'
  get 'portfolio/daily', to: 'portfolio#daily'
  get 'portfolio/weekly', to: 'portfolio#weekly'
  # Defines the root path route ("/")
  get 'landing_page', to: 'landing_page#new
  root "home#index"
end