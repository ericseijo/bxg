Bxg::Application.routes.draw do


  get "media_contact_messages/message_sent"

  resources :media_contact_messages

  get "releases_controller/new"
  get "releases_controller/create"
  match '/dashboard', to: 'dashboard#index'
  match '/releases/:id/upload', to: 'releases#upload', as: :releases_upload
  match '/releases/preview', to: 'releases#preview'

  resources :subscriptions
  resources :releases do
    resources :clients
    resources :distribution_lists
    resources :media_list do
      resources :media_contact_messages
    end
  end

  resources :clients do
    resources :releases
  end


  devise_for :users

  resources :users do

  end

  root :to => 'static_pages#home'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/plans', to: 'plans#index'



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  # Admin Section
  match 'admin' => 'admin/dashboard#index', :as => :admin_dashboard
  match 'admin/releases/:id/approve_release' => 'admin/releases#approve_release', :as => :admin_approve_release
  match 'admin/releases/email_user_release_notes' => 'admin/releases#email_user_release_notes'

  match 'view_release/:id' => 'view_release#show', :as => :view_release

  match 'releases/:id/email_release' => 'releases#email_release'
  match 'releases/:id/schedule_release' => 'releases#schedule_release', :as => :schedule_release
  match 'releases/:id/:media_list_id/pickup_release' => 'releases#pickup_release', :as => :release_pickup
  match 'press_release/:id' => 'releases#public_view', :as => :press_release



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
    namespace :admin do
      # Directs /admin/products/* to Admin::ProductsController
      # (app/controllers/admin/products_controller.rb)
      resources :plans
      resources :releases
    end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
