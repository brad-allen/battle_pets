Rails.application.routes.draw do
  root :to => 'home#index' 

  resources :battles
  resources :arenas
  resources :battle_pets
  resources :accounts
  devise_for :users
         
  namespace :v1, :defaults => { :format => :json } do 
     get :me, to: 'accounts#me'
     post :generate_pet, to: 'battle_pets#generate_pet'
     get :my_battle_pets, to: 'accounts#my_battle_pets'
     get :pet_leaderboard, to: 'battle_pets#leaderboard'
     
     get :my_battles, to: 'accounts#my_battles'
     get :my_battle_requests, to: 'accounts#my_battle_requests'
     get :leaderboard, to: 'accounts#leaderboard'

  	 resources :battles do
        put :accept
        put :deny
        post :battle_update
     end
	   
     resources :arenas do 
        get :battles
     end

     resources :battle_pets do
        get :battles
        get :train
        post :authed_get_pet_for_battle
        get :generate_training_pet
     end

     
     resources :accounts do
         get :battle_pets
         get :battles
     end
  end
end
