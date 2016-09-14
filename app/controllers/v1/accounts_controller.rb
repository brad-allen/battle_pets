class V1::AccountsController < V1::V1Controller  
  before_action :authenticate_user!, except: [:leaderboard]
  before_action only: [:update] { |c| c.check_permissions params[:id] }
  before_action only: [:show, :update] { |c| c.check_account params[:id] }
  before_action only: [:battles, :battle_pets] { |c| c.check_account params[:account_id] }

  def index
    @accounts = Account.all
    respond_with clean_public_json @accounts
  end

  def show
    respond_with clean_public_json @account
  end

  # GET /accounts/me.json
  def me
    return head(:unauthorized) unless current_user.present?

    @account = Account.find_by_id(account_id)
    return head(:not_found) unless @account.present?

    respond_with @account
  end

  def update
    @account.updated_by = account_id

    return head(:internal_server_error) unless @account.update(account_params)

    respond_with @account
  end

  #Non restful endpoints

  def my_battle_pets
    return head(:unauthorized) unless current_user.present?

    @account = Account.find_by_id(account_id)
    return head(:not_found) unless @account.present?

    respond_with @account.battle_pets
  end

  def my_battles
    return head(:unauthorized) unless current_user.present?

    @account = Account.find_by_id(account_id)
    return head(:not_found) unless @account.present?
    respond_with @account.get_battles
  end

  def my_battle_requests
    return head(:unauthorized) unless current_user.present?

    @account = Account.find_by_id(account_id)
    return head(:not_found) unless @account.present?

    challenges = Battle.find_by(user2_id:@account.id, status:"invited")
    
    respond_with (challenges.present? ? challenges : Array.new)
  end

  def leaderboard
   @accounts = Account.order(won: :desc, experience: :desc).take(100)
   respond_with clean_public_json @accounts
  end

  # GET /accounts/1/pets
  def battle_pets
    respond_with clean_battle_pet_json @account.battle_pets
  end

  # GET /accounts/1/battles
  def battles
    battles_started = Battle.find_by(user1_id:@account.id)
    challenges = Battle.find_by(user2_id:@account.id)
    results = battles_started.present? && challenges.present? ? battles_started+challenges : (battles_started.present? ? battles_started : (challenges.present? ? challenges : Array.new))
    
    respond_with results
  end

  #Helpers

  def check_permissions id
    return head(:forbidden) unless (id.present? && id == account_id.to_s) 
  end

  def check_account id
    @account = Account.find_by_id(id)
    return head(:not_found) unless @account.present?
  end


  def clean_public_json response
    response.as_json( :except => [:email] )
  end

  def clean_battle_pet_json response
    response.as_json( :except => [:email, :strength, :agility, :wit, :speed, :wisdom, :intelligence, :magic, :chi, :healing_power] )
  end

  private
    def account_params
      params.permit(:username, :user_id, :about, :email, :image, :town, :planet, :galaxy)
    end
end
