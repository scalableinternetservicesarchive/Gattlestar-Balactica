Rails.application.routes.draw do

  resources :messages, only: [:new, :create]

  root 'homepage#index'

  resources :users, :only => [:show]

  devise_for :user do
    get 'signin' => 'devise/sessions#new', as: 'new_user_session'
    post 'signin' => 'devise/sessions#create', as: 'user_session'
    delete 'signout' => 'devise/sessiosn#destroy', as: 'destroy_user_session'
    get 'signup' => 'devise/registration#new', as: 'new_user_registration'
  end

  get '/documents/:course_id/new', to: 'documents#new', as: 'new_document'
  get '/documents', to: 'documents#index', as: 'documents'
  get '/documents/:document_id/preview', to: 'documents#preview', as: 'preview_document'
  delete '/documents/:document_id/delete', to: 'documents#delete', as: 'delete_document'
  post '/documents/:course_id/create', to: 'documents#create', as: 'create_document'
  post '/documents', to: 'documents#vote', as: 'vote_document'
  get '/documents/:document_id/view', to: 'documents#view', as: 'view_document'


  get 'about',     to: 'homepage#about',   as: 'about'
  get 'contact',   to: 'homepage#contact', as: 'contact'
  get 'search_test', to: 'homepage#search_test', as: 'search_test'

  #user profile
  get '/user/add_course_taken', to: 'users#add_course_taken', as: 'add_course_taken'
  post '/user/add_course_taken_post', to: 'users#add_course_taken_post', as: 'add_course_taken_post'
  delete '/user/remove_course_taken/:department/:course_id', to: 'users#remove_course_taken', as: 'remove_course_taken'

  #admin
  get 'admin', to: 'users#admin_service', as: 'admin_service'

  #courses
  get '/courses/new', to: 'courses#new', as: 'add_new_course'
  post '/courses/create', to: 'courses#create', as: 'create_course'
  delete '/courses/:department/:course_id/delete', to: 'courses#delete', as: 'delete_course'

  #autocomplete
  get 'typeahead_department/:query' => 'search_results#typeahead_department'
  get 'typeahead_course_id/:query' => 'search_results#typeahead_course_id'

  post 'search',       to: 'search_results#search', as: 'search'
  get 'courses/:course_id', to: 'search_results#show_specific_course', as: 'search_specific_course'
  get 'department/:dpm',         to: 'search_results#show_department', as: 'search_dpm'
  get 'department/:dpm/:course', to: 'search_results#show_course',    as: 'search_course'
  get 'department/report', to: 'search_results#report', as: 'report'

  get 'forbidden', to: "error#catch_403", as: 'error_403'
  match "*path", to: "error#catch_404", via: :all
  # get ':dpm/:course/:test_id', to: 'document#index', as: 'document'

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
