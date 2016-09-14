class BattlesController < ApplicationController
  before_action :check_admin_permissions
  before_action :check_battle, only: [:show, :edit, :update, :destroy]

  def index
    @battles = Battle.all
  end

  def show
  end

  def new
    @battle = Battle.new
  end

  def edit
  end

  def create
    @battle = Battle.new(battle_params)
    @battle.call_auth_code = SecureRandom.uuid
    @battle.updated_by = account_id
    @battle.created_by = account_id

    respond_to do |format|
      if @battle.save
        format.html { redirect_to @battle, notice: 'Battle was successfully created.' }
        format.json { render :show, status: :created, location: @battle }
      else
        format.html { render :new }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @battle.updated_by = account_id
    
      if @battle.update(battle_params)
        format.html { redirect_to @battle, notice: 'Battle was successfully updated.' }
        format.json { render :show, status: :ok, location: @battle }
      else
        format.html { render :edit }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @battle.destroy
    respond_to do |format|
      format.html { redirect_to battles_url, notice: 'Battle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def check_battle
      @battle = Battle.find_by_id(params[:id])
      return head(:not_found) unless @battle.present?
    end

    def battle_params
      params.require(:battle).permit(:name, :user1_id, :user2_id, :arena_id, :pet1_id, :pet2_id, :play_for_keeps, :winner_experience, :loser_experience, :winner_gold, :battle_game_id, :status)
    end
end
