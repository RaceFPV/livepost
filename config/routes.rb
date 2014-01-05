Livepost::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root to: 'static_pages#home'
  
  match '/help',  to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  
  # The following routes should remain at the end of the file.
  # They are the catch-all for chat rooms slugs.
  # Do NOT remove unless you know what you are doing.
  match '/browse', to: 'chatlogs#index', via: 'get', as: 'chatlogs'
  resources :chatlogs, path: "", param: :id do
      resources :chatposts
  end
end
