Vino::Application.routes.draw do
	# get 'signup', to: 'users#new', as: 'signup'
	get 'login', to: 'sessions#new', as: 'login'
	delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
	resources :posts
	resources :sessions
  
  root 'posts#blog'
end
