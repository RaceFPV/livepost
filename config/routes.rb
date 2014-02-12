Livepost::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root to: 'static_pages#home'
  
  match '/help',  to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
  #generate routes for users
  match '/signup', to: 'identities#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: 'sessions#failure', via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post, :delete]
  
  #generate default routes for users
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :identities
  
  
  # The following routes should remain at the end of the file.
  # They are the catch-all for chat rooms slugs.
  # Do NOT remove unless you know what you are doing.
  match '/browse', to: 'chatlogs#index', via: 'get', as: 'chatlogs'
  resources :chatlogs, path: "", param: :id do
      resources :chatposts
  end
end
