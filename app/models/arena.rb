class Arena < ApplicationRecord
      
	validates :name, presence: true, length: { maximum: 100 }
    validates :url, presence: true
    validates :port, presence: true, numericality: { only_integer: true }
    #validates :status, presence: true, length: { maximum: 25 }, inclusion: { in: %w(open closed removed), message: "Status is not valid" }, allow_nil: false

end
