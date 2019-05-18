Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/users', to: 'users#create'
      get '/users/sign_in', to: 'sessions#new'
      post '/sessions/generate_new_otp', to: 'sessions#generate_new_otp'
      post '/sessions/verify_otp', to: 'sessions#verify_otp'
      get '/products', to: 'products#index'
    end
  end
end
