require 'time_constraint'

Railbook::Application.routes.draw do

	root :to => 'books#index'

  resources :members

  resources :fun_comments, :path_names => { :new => 'insert', :edit => 'revise' }

  resources :reviews do
		collection do
			get 'unapproval'
		end
		member do
			get 'draft'
		end
	end

  resources :authors

  resources :users, :only => ['index', 'new', 'create', 'edit', 'update']

	namespace 'admin' do
		resources :books, :constraints => TimeConstraint.new
	end

	resource :cofing

	resources :books do
		resources :reviews
	end

	match '/blogs/:user_id' => 'blogs#index'

	match 'hello/view'

	match 'hello/view', :via => :get

	match '/articles(/:category)' => 'articles#index', :defaults => { :category => 'general', :format => 'xml' }

	match '/blogs/:user_id' => 'blogs#index', :constrains => { :user_id => /[A-Za-z0-9]{3,7}/ }

	match ':controller(/:action(:id))', :controller => /common\/[^\/]+/

	match 'articles' => 'main#index'

	match 'articles/*category/:id' => 'articles#category'

	match '/books/:id' => redirect('/martciles/%{id}/')

	match '/books/:id' => redirect{|p, req| "/articles/#{p[:id].to_i + 10000}"}
	#get "hello/list"

  #get "hello/index"

  #get "hello/view"

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
  match ':controller(/:action(/:id(.:format)))'
end
