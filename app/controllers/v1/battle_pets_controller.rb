class V1::BattlePetsController < V1::V1Controller
  before_action :authenticate_user!, except: [:show, :index, :authed_get_pet_for_battle, :generate_training_pet, :leaderboard]
  before_action :check_admin_permissions, only: [:create]
  before_action only: [:show, :update] { |c| c.check_battle_pet params[:id] }
  before_action only: [:battles, :authed_get_pet_for_battle, :train, :generate_training_pet] { |c| c.check_battle_pet params[:battle_pet_id] }

  def index
    @battle_pets = BattlePet.where(retired:false)
    respond_with clean_public_json @battle_pets
  end

  def show
    respond_with clean_public_json @battle_pet
  end

  #Admin only create, users go through generate_pet
  def create

    @battle_pet = BattlePet.new(battle_pet_params)
    @battle_pet.account = current_user.account
    set_created_at_fields

    return head(:internal_server_error) unless @battle_pet.save

    respond_with @battle_pet
  end


  def update
    return head(:forbidden) unless @battle_pet.account_id == account_id
    
    @battle_pet.updated_by = account_id
    return head(:internal_server_error) unless @battle_pet.update(battle_pet_params)    

    respond_with @battle_pet
  end

  #Non restful endpoints

  def authed_get_pet_for_battle
    auth_code = params[:call_auth_code] if params[:call_auth_code].present? 
    return head(:forbidden) unless params[:call_auth_code].present? && @battle_pet.pet_battle_exists(auth_code)

    respond_with @battle_pet
  end

  # POST /battle_pets/generate_pet.json
  # name, about, image, town, planet, galaxy
  def generate_pet
    @battle_pet = BattlePet.new(user_battle_pet_params) 
    @battle_pet.account = current_user.account
    @battle_pet.initialize_pet    
    set_created_at_fields

    return head(:internal_server_error) unless @battle_pet.save
    
    respond_with @battle_pet
  end


  # GET /battle_pets/1/battles
  def battles
    respond_with clean_public_json (@battle_pet.get_battles)
  end

  def leaderboard
   @battle_pet = BattlePet.order(won: :desc, experience: :desc).take(100)
   respond_with clean_public_json @battle_pet
  end


 # GET /battle_pets/generate_random_pet.json
  def generate_training_pet
    new_battle_pet =  @battle_pet.generate_training_battle_pet

    respond_with new_battle_pet
  end


  #TODO update train to allow training in different arenas and with different battle games
  def train
    return head(:forbidden) unless @battle_pet.account_id == account_id
    
    battle = Battle.create_training_battle @battle_pet, 1
    
    return head(:bad_gateway) unless battle.send_battle_to_arena

    respond_with battle
  end

  #Helpers

  def clean_public_json response
    response.as_json( :except => [:strength, :agility, :wit, :speed, :wisdom, :intelligence, :magic, :chi, :healing_power] )
  end

  def check_battle_pet id
    @battle_pet = BattlePet.find_by_id(id)
    return head(:not_found) unless @battle_pet.present?
  end

  private

  def set_created_at_fields
    @battle_pet.updated_by = account_id
    @battle_pet.created_by = account_id
    @battle_pet.original_owner_id = account_id
    @battle_pet.account_id = account_id
  end

  def user_battle_pet_params
      params.permit(:name, :about, :image, :town, :planet, :galaxy, :retired, :auto_accept_play_for_points_requests)
    end 

    def battle_pet_params
      params.permit(:name, :about, :image, :level, :experience, :won, :lost, :tied, :town, :planet, :galaxy, :retired, :auto_accept_play_for_points_requests, :status, :account_id, :previous_owner_id, :original_owner_id, :strength, :agility, :wit, :speed, :wisdom, :intelligence, :magic, :chi, :healing_power, :status)
    end
end
