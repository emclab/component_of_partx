ComponentOfPartx::Engine.routes.draw do
  resources :components
  
  root :to => 'components#index'

end
