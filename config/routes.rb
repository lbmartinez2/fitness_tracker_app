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

  get 'bmr_and_amr/new', to: 'bmr_and_amr#new', as: 'new_bmr_and_amr'
  post 'bmr_and_amr/calculate', to: 'bmr_and_amr#calculate', as: 'calculate_bmr_and_amr'

  get 'bmr_and_amr/show', to: 'bmr_and_amr#show', as: 'show_bmr_and_amr'

  # Defines the root path route ("/")
  root "home#index"
end
