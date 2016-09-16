class Arena < ApplicationRecord
      
	validates :name, presence: true, length: { maximum: 100 }
    validates :url, presence: true
    validates :port, presence: true, numericality: { only_integer: true }
  
    def self.get_arena_for_fight arena_id
	    if arena_id.present?
	    	arena = Arena.find_by_id(arena_id)
	    	return arena if arena.present? && arena.id > 0
	    end
	    return Arena.new({name:'Default Arena', description:"You don't have any arenas in your system.", url:DEFAULT_ARENA_V1_BATTLES_URL, port: DEFAULT_ARENA_PORT })
	 end
end
