Vino::Application.routes.draw do
  resources :posts
  
  root 'posts#blog'
end
