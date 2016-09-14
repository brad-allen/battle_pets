class Account < ApplicationRecord
  has_many :battle_pets
  belongs_to :user

  validates :permission, presence: true, length: { maximum: 25 }, inclusion: { in: %w(user admin), message: "Permission is not valid" }, allow_nil: false
  validates :status, presence: true, length: { maximum: 25 }, inclusion: { in: %w(active locked removed), message: "Status is not valid" }, allow_nil: false
  validates :user_id, presence: true, numericality: { only_integer: true }


  def level_up 
  	if experience >= level * USER_LEVEL_UP_EXPERIENCE
  		self.level = level + 1
  	end
  end

  def get_battles
    #TODO update model associations for many to many battles to users
    battles_started = Battle.where(user1_id:id)
    challenges = Battle.where(user2_id:id)
    results = battles_started.present? && challenges.present? ? battles_started+challenges : (battles_started.present? ? battles_started : (challenges.present? ? challenges : Array.new))
  end
  
end
