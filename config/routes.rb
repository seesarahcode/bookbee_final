Bookbee::Application.routes.draw do
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :books

  root 'static_pages#home'

  match '/signup',  to: 'users#new',     via: 'get'
  match '/signin',  to: 'sessions#new',  via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/faq',     to: 'static_pages#faq', via: 'get'
  
  get '/pending_approval', to: 'books#pending_approval', as: 'pending'
 
 end