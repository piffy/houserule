Houserule::Application.routes.draw do


  resources :archived_events, except: [:new, :create]

  resources :groups do
    resources :interests
    match  'linked_events/:event_id/confirm', :to => "linked_events#confirm"
    resources :linked_events
    resources :events, only: [:new]
  end

  get "info/index"
  get "info/about"
  get "info/contact"
  get "info/license"
  get "info/feedback"
  get "info/help"
  get "info/faq"


  #match  'announcements/compose', :to => "announcements#compose", :as => "compose", :path_prefix => "/event/:event_id"

  resources :events do
    resources :reservations, only: [:new, :create, :destroy, :show]
    resources :announcements, only: [:new, :create]
    resources :invitations
    resources :event_wizard
    match  'archived_events/new', :to => "archived_events#new", :as => "archive"
    match  'archived_events', :to => "archived_events#create", :via => :post
    match  'announcements/compose', :to => "announcements#compose", :as => "compose"
    match  'announcements/deliver', :to => "announcements#deliver", :as => "deliver" , :via => :post
  end

  match 'users/:id/deactivate', :to => 'users#deactivate'

  get "users/show"

  resources :users#  , :collection =>{ :deactivate => :get }

  get "welcome/index"
  get "welcome/administration", :as => "administration"
  get "welcome/wall"
  match "welcome/wall", :to => "welcome#deliver", :as => "deliver" , :via => :post

  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, :only => [ :new, :create, :edit, :update ]

  match '/registrazione',  to: 'users#new'
  match '/login',  to: 'sessions#new'
  match '/logout', to: 'sessions#destroy', via: :delete

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
