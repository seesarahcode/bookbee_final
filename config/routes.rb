Bookbee::Application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'

  resources :users do
    resources :follows do
      collection do
        post 'edit_multiple'
        post 'update_multiple'
      end
    end 
  end
  
  resources :invitations
  resources :sessions, only: [:new, :create, :destroy]
  resources :books do
    resources :reviews
  end

  root 'static_pages#home'

  match '/signup',  to: 'users#new',     via: 'get'
  match '/signin',  to: 'sessions#new',  via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/faq',     to: 'static_pages#faq', via: 'get'

  match '/admin_signup', to: 'users#new_admin', via: 'get'
  match '/email_preferences', to: 'users#email_preferences', via: 'get'

  get '/tagged', to: 'books#tagged', as: 'tagged'
  get '/pending_approval', to: 'books#pending_approval', as: 'pending'
  get '/mybooks', to: 'books#user_library', as: 'user_books'
 
 end