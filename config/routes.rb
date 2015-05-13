Vino::Application.routes.draw do

  root 'posts#index'
  get 'atom', to: 'posts#index', format: 'atom'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  namespace :admin do
    get '', to: 'posts#index'
    resources :posts
  end

  resources :users
  resources :posts
  resources :sessions

end
