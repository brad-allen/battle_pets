class AccountsController < ApplicationController
  before_action :check_admin_permissions
  before_action :check_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.all
  end

  def show
  end

  def new
    @account = Account.new
  end

  def edit
  end

  def create
    @account = Account.new(account_params)
    @account.updated_by = account_id
    @account.created_by = account_id


    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @account.updated_by = account_id

      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def check_account
      @account = Account.find_by_id(params[:id])
      return head(:not_found) unless @account.present?
    end

    def account_params
      params.require(:account).permit(:username, :user_id, :about, :email, :image, :level, :experience, :gold, :won, :lost, :tied, :town, :planet, :galaxy)
    end
end
