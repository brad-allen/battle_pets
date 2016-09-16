class V1::BattlesController < V1::V1Controller
  before_action :authenticate_user!, except: [:battle_update]
  before_action only: [:accept, :deny] { |c| c.check_responder_permissions params[:battle_id] }
  before_action only: [:invite, :accept, :deny] { |c| c.check_battle params[:battle_id] }
  before_action only: [:update] { |c| c.check_owner_permissions params[:id] }
  before_action only: [:show, :update] { |c| c.check_battle params[:id] }

  def index
    @battles = Battle.all
    respond_with @battles
  end

  def show
    respond_with @battle
  end

# PUT /battles/1/accept
  def accept
    return head(:bad_request) unless @battle.status == "invited"
    
    @battle.status = "accepted"
    @battle.updated_by = account_id 
    return head(:internal_server_error) unless  @battle.save

    return head(:bad_gateway) unless @battle.send_battle_to_arena
   
    respond_with @battle
  end  

  def create
    
    @battle = Battle.new(battle_params)
    
    pet = BattlePet.find_by_id(@battle.pet2_id)
    return head(:forbidden) unless @battle.user1_id == account_id && @battle.user2_id != account_id
    return head(:not_found) unless pet.present? && !pet.retired
    

    @battle.call_auth_code = SecureRandom.uuid
    @battle.updated_by = account_id 
    @battle.created_by = account_id 
 
    if (!@battle.play_for_keeps.present? || !@battle.play_for_keeps) && (pet.auto_accept_play_for_points_requests.present? && pet.auto_accept_play_for_points_requests)
      @battle.status = "auto-accepted"
      return head(:internal_server_error) unless @battle.save      
      @battle.send_battle_to_arena and return
    end

    @battle.status = "invited"
    return head(:internal_server_error) unless @battle.save 

    respond_with @battle
  end

  def update
    @battle.updated_by = account_id 

    return head(:internal_server_error) unless  @battle.update(battle_params)

    respond_with @battle
  end


  #Non restful endpoints
  #endpoint called by arenas to give battle completion update
  # PUT /battles/1/battle_update
  def battle_update
    puts "WELCOME BACK !!!!"
    update_values = params.permit(:id, :battled_on, :winning_user_id, :winning_pet_id, :is_tie, :status, :original_id, :score, :call_auth_code, :winner_experience, :loser_experience, :winner_gold)
    
    original_battle = Battle.find_by_id(update_values[:original_id])

    return head(:forbidden) unless update_values['call_auth_code'] == original_battle.call_auth_code

    original_battle.update_battle_from_response update_values
    
    original_battle.process_battle_results 

    head(:ok)
  end

# PUT /battles/1/deny
  def deny
      return head(:bad_request) unless @battle.status == "invited"
    
    @battle.status = "denied"
    @battle.updated_by = account_id 
    return head(:internal_server_error) unless  @battle.save

    respond_with @battle
  end

  #Helpers

  def check_owner_permissions id
      battle = Battle.find_by_id(id)
      return head(:forbidden) unless battle.present? && battle.created_by == account_id   
    end


    def check_responder_permissions id
      battle = Battle.find_by_id(id)
      return head(:forbidden) unless battle.present? && battle.user2_id == account_id    
    end

    def check_battle id
      @battle = Battle.find_by_id(id)
      return head(:not_found) unless @battle.present? 
    end

  private

    def battle_params
      params.permit(:name, :user1_id, :user2_id, :arena_id, :pet1_id, :pet2_id, :play_for_keeps, :battle_game_id, :status)
    end
end
