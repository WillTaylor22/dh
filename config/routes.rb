Driverhunt::Application.routes.draw do




  resources :categories

  # match 'auth/:provider/callback', to: 'users/sessions#create'
  # match 'auth/failure', to: redirect('/')
  # match 'signout', to: 'users/sessions#destroy', as: 'signout'


  devise_for :users, controllers: { sessions: "users/sessions",
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks" }
  root 'homepage#home'
  get '/post-job', to: 'homepage#post_job', as: "post_job"
  get '/dashboard', to: 'pages#projects'
  get '/chat', to: 'pages#chat'
  get '/drivers', to: 'pages#drivers'
  get '/jobs', to: 'pages#jobs'
  get '/help', to: 'homepage#help'
  get '/u/:username', to: 'pages#profile', as: 'user'
  get '/job/:id', to: 'pages#job', as: 'job'

  # profile editing
  get '/edit_name', to: 'pages#edit_name', as: 'edit_name'
  get '/edit_summary', to: 'pages#edit_summary', as: 'edit_summary'
  get '/edit_description', to: 'pages#edit_description', as: 'edit_description'
  get '/edit_postcode', to: 'pages#edit_postcode', as: 'edit_postcode'
  get '/upload_photo', to: 'pages#upload_photo', as: 'upload_photo'
  get '/crop', to: 'pages#crop', as: 'crop'
  get '/add_experience_item', to: 'pages#add_experience_item', as: 'add_experience_item'
  get '/edit_experience_item/:id', to: 'pages#edit_experience_item', as: 'edit_experience_item'
  get '/add_qualification_item', to: 'pages#add_qualification_item', as: 'add_qualification_item'
  get '/edit_qualification_item/:id', to: 'pages#edit_qualification_item', as: 'edit_qualification_item'

  resources :jobs
  resources :qualification_items
  resources :experience_items

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
