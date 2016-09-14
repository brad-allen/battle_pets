class User < ApplicationRecord
  after_create :create_account

  has_one :account

    # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def create_account
      Account.create(username:"Unknown Hero", email: email, user_id:id, created_by:id, updated_by:id, won:0, lost:0, tied:0, gold:0, experience:0, level:1, permission:'user', status:'active') 
  end

end
