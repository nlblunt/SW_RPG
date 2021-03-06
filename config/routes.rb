SWRpg::Application.routes.draw do
  #Resources
  resources :weapon
  resources :armor
  resources :item

  #GM CONTROLLER ROUTES
  get 'gm/gm_check' => "gm#gm_check"
  post 'gm/get_all_pcs' => "gm#get_all_pcs"
  post 'gm/modify_pc' => "gm#modify_pc"
  post 'gm/pc_modify_strain' => "gm#pc_modify_strain"
  post 'gm/pc_modify_wounds' => "gm#pc_modify_wounds"
  post 'gm/get_session_pcs' => "gm#get_session_pcs"
  post 'gm_add_session_pcs' => "gm#add_session_pcs"
  
  #CAREER CONTROLLER ROUTES
  get 'career/index'
  get "career/get_career_specializations/:id" => "career#get_career_specializations"
  get "career/get_all_specializations" => "career#get_all_specializations"
  get "career/get_specialization_career_skills/:id" => "career#get_specialization_career_skills"
  
  #PLAYER CONTROLLER ROUTES
  resources :player
  get "player/get_pc/:id" => "player#get_pc"
  post "player/get_player_pcs" => "player#get_player_pcs"
  get "users/player_check" => "player#player_check"
  post "player/create_pc" => "player#create_pc"
  post "player/delete_pc" => "player#delete_pc"
  get "player/get_pc_xp/:id" => "player#get_pc_xp"
  post "player/get_pc_skills" => "player#get_pc_skills"
  get "player/get_pc_career_skills/:id" => "player#get_pc_career_skills"
  post "player/increase_skill_rank" => "player#increase_skill_rank"
  post "player/increase_attribute" => "player#increase_attribute"
  post "player/set_specialization" => "player#set_specialization"
  post "player/set_pc_status" => "player#set_pc_status"
  post "player/get_pc_weapons" => "player#get_pc_weapons"
  post "player/get_pc_armor" => "player#get_pc_armor"
  post "player/get_pc_items" => "player#get_pc_items"
  post "player/add_weapon" => "player#add_weapon"
  post "player/delete_weapon" => "player#delete_weapon"
  post "player/add_armor" => "player#add_armor"
  post "player/delete_armor" => "player#delete_armor"
  post "player/add_item" => "player#add_item"
  post "player/delete_item" => "player#delete_item"
  
  #RACE CONTROLLER ROUTES
  get 'race/index'

  #GAME CONTROLLER ROUTES (GAME SESSION)
  get 'game/get_all_sessions' => "game#get_all_sessions"
  post 'game/create_session' => "game#create_session"
  post 'game/restore_session' => "game#restore_session"
  
  #GENERIC ROUTES
  devise_for :users, controllers: { sessions: "users/sessions"}
  devise_for :gms, controllers: { sessions: "gm/sessions"}
  
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
