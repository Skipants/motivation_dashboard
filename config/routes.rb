MotivationdashboardCom::Application.routes.draw do
  
  root :to => "pages#home"
  get 'features', :to => "pages#features"
  get 'pricing', :to => "pages#pricing"

  resources :users do
    get :reset_api_key
  end
  resources :user_session
  resources :widget_templates
  match '/logout' => 'user_sessions#destroy', :as => :logout
  match '/forgot_password' => 'password_resets#new', :as => :forgot_password
  match '/reset_password/:perishable_token' => 'password_resets#edit', :as => :reset_password
  resources :password_resets

  resources :widgets
  resources :data_sources  
  
  resource :dashboard
  
  namespace :setup do
    root :to => "data_sources#index"
    resources :data_sources do
      collection do
        get :auth_receive
      end
      resources :data_sets do
        resources :reports do
          resources :widgets
        end
      end
    end
  end
  
  namespace :integrations do
    
    resources :github do
      collection do
        post 'post_receive_hook'
      end
    end
    
  end
  
  namespace :big_brother do
    root :to => "pages#index"
    resources :users do
      collection do
        get :search
      end
    end
    resources :subscribers
  end
  
  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
