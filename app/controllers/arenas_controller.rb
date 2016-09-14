class ArenasController < ApplicationController
  before_action :check_admin_permissions
  before_action :check_arena, only: [:show, :edit, :update, :destroy]  
  
  def index
    @arenas = Arena.all
  end

  def show
  end

  def new
    @arena = Arena.new
  end

  def edit
  end

  def create
    
    @arena = Arena.new(arena_params)
    @arena.updated_by = account_id
    @arena.created_by = account_id

    respond_to do |format|
      if @arena.save
        format.html { redirect_to @arena, notice: 'Arena was successfully created.' }
        format.json { render :show, status: :created, location: @arena }
      else
        format.html { render :new }
        format.json { render json: @arena.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @arena.updated_by = account_id
      
      if @arena.update(arena_params)
        format.html { redirect_to @arena, notice: 'Arena was successfully updated.' }
        format.json { render :show, status: :ok, location: @arena }
      else
        format.html { render :edit }
        format.json { render json: @arena.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @arena.destroy
    respond_to do |format|
      format.html { redirect_to arenas_url, notice: 'Arena was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def check_arena
      @arena = Arena.find_by_id(params[:id])
      return head(:not_found) unless @arena.present?
    end

    def arena_params
      params.require(:arena).permit(:name, :description, :rated, :url, :port)
    end
end
