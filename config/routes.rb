ChessCamp::Application.routes.draw do
  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps

  # New routes added:
  resources :families
  resources :locations
  resources :students
  resources :users
  resources :sessions
  resources :registrations

# Authentication routes
  get 'user/edit' => 'users#edit', as: :edit_current_user
  get 'signup' => 'users#new', as: :signup
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login' => 'sessions#new', as: :login

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/guest', to: 'home#guest', as: :guest
  get 'home/help', to: 'home#help', as: :help

  # set the root url
  root to: 'home#index'

end
