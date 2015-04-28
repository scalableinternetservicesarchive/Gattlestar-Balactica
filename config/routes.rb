Rails.application.routes.draw do

  devise_for :user do
    get 'signin' => 'devise/sessions#new', as: 'new_user_session'
    post 'signin' => 'devise/sessions#create', as: 'user_session'
    delete 'signout' => 'devise/sessiosn#destroy', as: 'destroy_user_session'
    get 'signup' => 'devise/registration#new', as: 'new_user_registration'
  end

  resources :documents

  root 'homepage#index'

  get 'about',     to: 'homepage#about',   as: 'about'
  get 'contact',   to: 'homepage#contact', as: 'contact'

  get '/typeahead_department/:query' => 'search_results#typeahead_department'
  get '/typeahead_course_id/:query' => 'search_results#typeahead_course_id'

  post 'search',       to: 'search_results#search', as: 'search'
  get 'courses/:course_id', to: 'search_results#show_specific_course', as: 'search_specific_course'
  get ':dpm',         to: 'search_results#show_department', as: 'search_dpm'
  get ':dpm/:course', to: 'search_results#show_course',    as: 'search_course'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
