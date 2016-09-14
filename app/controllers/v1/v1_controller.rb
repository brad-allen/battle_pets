class V1::V1Controller < ActionController::Base
	respond_to :json

	def account_id 
	 	current_user.account.id
	end
  

  	def check_admin_permissions
  	   user = Account.find_by_id(account_id )
      return head(:forbidden) unless user.present? && user.permission == 'admin'
  	end
 
end
