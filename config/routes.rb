Vino::Application.routes.draw do
  resources :users

  resources :posts
  
  root 'posts#blog'
end
