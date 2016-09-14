class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception	
  before_action :authenticate_user!
  before_action :load_account_information


  def load_account_information 
  	return @account = current_user.account if current_user.present? && current_user.account.present?
  	@account = Account.new
  end

  def account_id 
  	current_user.account.id
  end

  	def check_admin_permissions
  		user = Account.find_by_id(account_id)
    	return head(:forbidden) unless user.present? && user.permission == 'admin'
  	end
end
