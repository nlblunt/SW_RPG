SWRpg::Application.routes.draw do
  #CAREER CONTROLLER ROUTES
  get 'career/index'
  get "career/get_career_specializations/:id" => "career#get_career_specializations"
  get "career/get_all_specializations" => "career#get_all_specializations"
  
  #PLAYER CONTROLLER ROUTES
  resources :player
  get "users/player_check" => "player#player_check"
  post "player/create_pc" => "player#create_pc"
  get "player/get_pc_skills/:id" => "player#get_pc_skills"
  get "player/get_pc_career_skills/:id" => "player#get_pc_career_skills"
  post "player/increase_skill_rank" => "player#increase_skill_rank"
  post "player/set_specialization" => "player#set_specialization"
  
  #RACE CONTROLLER ROUTES
  get 'race/index'

  #GENERIC ROUTES
  devise_for :users, controllers: { sessions: "users/sessions"}
  get "welcome/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
