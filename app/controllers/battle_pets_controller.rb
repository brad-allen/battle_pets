class BattlePetsController < ApplicationController
  before_action :check_admin_permissions
  before_action :check_battle_pet, only: [:show, :edit, :update, :destroy]

  def index
    @battle_pets = BattlePet.all
  end

  def show
  end

  def new
    @battle_pet = BattlePet.new
  end

  def edit
  end

  def create
    @battle_pet = BattlePet.new(battle_pet_params)
    @battle_pet.updated_by = account_id
    @battle_pet.created_by = account_id
    @battle_pet.account = current_user.account
      
    respond_to do |format|
      if @battle_pet.save
        format.html { redirect_to @battle_pet, notice: 'Battle pet was successfully created.' }
        format.json { render :show, status: :created, location: @battle_pet }
      else
        format.html { render :new }
        format.json { render json: @battle_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    
    respond_to do |format|
      @battle_pet.updated_by = account_id
      
      if @battle_pet.update(battle_pet_params)
        format.html { redirect_to @battle_pet, notice: 'Battle pet was successfully updated.' }
        format.json { render :show, status: :ok, location: @battle_pet }
      else
        format.html { render :edit }
        format.json { render json: @battle_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @battle_pet.destroy
    respond_to do |format|
      format.html { redirect_to battle_pets_url, notice: 'Battle pet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def check_battle_pet
      @battle_pet = BattlePet.find_by_id(params[:id])
      return head(:not_found) unless @battle_pet.present?
    end

    def battle_pet_params
      params.require(:battle_pet).permit(:name, :about, :image, :level, :experience, :won, :lost, :tied, :town, :planet, :galaxy, :retired, :auto_accept_play_for_points_requests, :status, :account_id, :previous_owner_id, :original_owner_id, :strength, :agility, :wit, :speed, :wisdom, :intelligence, :magic, :chi, :healing_power, :status)
    end
end
