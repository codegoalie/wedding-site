WeddingSite::Application.routes.draw do

  devise_for :users do
    get '/signin', :to => 'devise/sessions#new', :as => 'sign_in'
    get '/signout', :to => 'devise/sessions#destroy', :as => 'sign_out'
  end

  resources :guests, :meals
  resources :invitations do
    collection do
      get :choose
      get :inserts
      post :populate
    end
  end
  resources :payments, :except => [ :show ]
  resources :budget_items, :path => 'budget'
  resources :attendees do
    collection do
      get :seating_chart
    end
  end

 
  match '/pics' => 'welcome#pics', :as => 'pics'
  match '/game' => 'welcome#game', :as => 'game'
  match '/info' => 'welcome#info', :as => 'info'
  match '/news' => 'welcome#news', :as => 'news'
  match '/registry' => 'welcome#registry', :as => 'registry'

  get '/rsvp/:id_hash' => 'rsvp#rsvp_verify_form', :as => 'rsvp_verify_form'
  post '/rsvp/:id_hash' => 'rsvp#rsvp', :as => 'rsvp'
  post '/rsvp-select/:id_hash' => 'rsvp#rsvp_response', :as => 'rsvp_response'
  #get '/rsvp/:id_hash/response_test' => 'rsvp#response_test'
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
  root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
