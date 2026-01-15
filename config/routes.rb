Rails.application.routes.draw do
  root 'pages#home'
  
  namespace :api do
    resources :rooms, only: [:index]
    get :availability, to: 'availability#index'
    resources :bookings, only: [:create]
  end

  get 'confirmation/:id', to: 'bookings#show', as: :booking_confirmation
end
