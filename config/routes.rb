HomeBinder::Application.routes.draw do
  
  mount StripeEvent::Engine => '/subscriptions/webhook', :as => 'stripe_webhook'
  
  namespace :api do
    namespace :v1 do
      devise_for :users
      resources :config,                  :only => [:index]
      resources :registrations,           :only => [:create, :show]
      resources :user_tokens,             :only => [:create, :destroy]
      resources :users,                   :only => [:show]
      resources :user_profiles,           :only => [:index, :update]
      resources :passwords,               :only => [:create, :update]
      #resources :sessions,                :only => [:create, :show, :update, :destroy]
      resources :binders do
        resources :notes
        resources :shares,                :only => [:index, :create]

        ## Added by Jessica for Onboarding Wizard UI #
        #resources :onboarding_wizard,     :only => [:index]

      end
      resources :property_types,          :only => [:index]
      resources :structures do
        resources :notes
      end
      resources :construction_styles,     :only => [:index]
      resources :construction_types,      :only => [:index]
      resources :heat_types,              :only => [:index]
      resources :heat_sources,            :only => [:index]
      resources :areas do
        resources :notes
      end
      resources :area_types,              :only => [:index]
      resources :appliances do
        resources :notes
      end
      resources :paints do
        resources :notes
      end
      resources :paint_manufacturers,     :only => [:index]
      resources :paint_types,             :only => [:index]
      resources :finishes do
        resources :notes
      end
      resources :maintenance_items do
        resources :notes
      end
      resources :maintenance_cycles,      :only => [:index]
      resources :maintenance_events
      resources :projects do
        resources :notes
      end
      resources :project_types,           :only => [:index]
      resources :project_statuses,        :only => [:index]
      resources :binder_contractors do
        resources :notes
      end
      resources :contractor_types,        :only => [:index]
      resources :appliances do
        resources :notes
      end
      resources :appliance_manufacturers, :only => [:index]
      resources :appliance_models,        :only => [:index]
      resources :inventory_items do
        resources :notes
      end
      resources :inventory_item_types,    :only => [:index]
      resources :finishes do
        resources :notes
      end
      resources :finish_makes,            :only => [:index]
      resources :finish_models,           :only => [:index]
      resources :receipts do
        resources :notes
      end
      resources :stores,                  :only => [:index]
      resources :contractors,             :only => [:show]
      resources :shares,                  :only => [:index, :update, :destroy]
      resources :subscriptions
      resources :plans,                   :only => [:show]
      resources :coupons,                 :only => [:show]
      resources :documents
      resources :images
      resources :reports,                 :only => [:index]
      resources :tags,                    :only => [:create, :destroy]
      resources :user_roles,              :only => [:create]
      resources :partners
      resources :logos,                   :only => [:index, :create, :destroy]   
      resources :seller_reports,          :only => [:create, :show, :update] 
      resources :seller_report_pdfs,      :only => [:show]
      resources :recalls,                 :only => [:index]
      resources :transfers,               :only => [:create]
      resources :free_trials,             :only => [:create]
    end
  end

  namespace :admin do
    resources :users,                :only => [:index, :destroy]
    resources :partners
    resources :logos
    resources :seller_reports,       :only => [:index]
    resources :user_roles,           :only => [:create]
  end
  
  resources :api_keys

  root :to => "home#index"

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
