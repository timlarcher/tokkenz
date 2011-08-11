Tokkenz::Application.routes.draw do

  resources :stores
  resources :stars
  resources :series
  resources :characters
  resources :packs
  resources :tokens
  resources :trades do
    get 'search', :on => :collection
    get 'cancel', :on => :member
  end
  resources :bids do
    get 'trade_bids', :on => :collection
    get 'accept', :on => :member
    get 'cancel', :on => :member
  end
  resources :players do
    get 'login', :on => :collection
    get 'signup', :on => :collection
    get 'signup', :on => :member
    get 'favorites', :on => :member
  end
  resources :sessions, :only => [:new, :create, :destroy]

  match '/home', :to => 'home#welcome'
  match '/contact', :to => 'main#contact'
  match '/about', :to => 'main#about'
  match '/help', :to => 'main#help'
  match '/jobs', :to => 'main#jobs'
  match '/whats_new', :to => 'main#whats_new'
  match 'search', :to => 'main#search'
  match '/signup', :to => 'players#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  root :to => "main#welcome"

end
