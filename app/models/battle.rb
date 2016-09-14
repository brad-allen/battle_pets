require "net/http"
require "uri"

class Battle < ApplicationRecord
	
	#attr_accessor :arena_id, :id, 

	validates :name, presence: true, length: { maximum: 100 }
  	validates :call_auth_code, presence: true
  	validates :user1_id, presence: true, numericality: { only_integer: true }
  	validates :user2_id, presence: true, numericality: { only_integer: true }
  	validates :pet1_id, presence: true, numericality: { only_integer: true }
  	validates :pet2_id, presence: true, numericality: { only_integer: true }
  	validates :status, presence: true, length: { maximum: 25 }, inclusion: { in: %w(auto-accepted battled invited accepted legendary denied), message: "Status is not valid" }, allow_nil: false

	def send_battle_to_arena	 

		self.save unless id.present?

		fight_extension = id.to_s + '/fight'
		uri = URI.parse(DEFAULT_ARENA_V1_BATTLES_URL + id.to_s + '/fight')	    #default for now, move to common area
		
		port = DEFAULT_ARENA_PORT

	    if arena_id.present?
	    	arena = Arena.find_by_id(arena_id)
	    	if arena.present? && arena.id > 0
				uri = URI.parse(arena.url+'/v1/battles/' +fight_extension) 				
				port = arena.port
	    	end
	    end

		http = Net::HTTP.new(uri.host, port)
		request = Net::HTTP::Post.new(uri.request_uri)
		request.set_form_data(self.as_json)

		begin
			response = http.request(request)
			puts 'SENT ARENA BATTLE REQUEST : response =>' + response.inspect
			true
		rescue
			puts 'FAILED ARENA BATTLE REQUEST : response =>' + response.inspect
			puts 'FAILED ARENA BATTLE REQUEST : arena =>' + arena.inspect
			puts 'FAILED ARENA BATTLE REQUEST : url =>' + arena.inspect
			
			false
		end		
	 end

	 #TODO break this up so the specific models update themselves, after tests in for battle model
	def process_battle_results
		self.status = "legendary"

		if self.is_tie
			user1 = Account.find_by_id(user1_id)
			if(user1.present?)
				user1.tied = user1.tied + 1
				user1.save
			end

			user2 = Account.find_by_id(user2_id)
			if(user2.present?)
				user2.tied = user2.tied + 1
				user2.save
			end
			return
		end

		is_training = pet2_id == -1

		#training may not have real users or pets or a pet may disappear by the time the battle is over		
		winner = Account.find_by_id(winning_user_id.present? ? winning_user_id : -1)		
		if(winner.present?)
			
			winner.won = winner.won + 1 unless is_training
			winner.experience = winner.experience + (winner_experience.present?  ? winner_experience :  0)
			winner.gold = winner.gold + (winner_gold.present? ? winner_gold :  0)
			winner.level_up
			winner.save

		end


		winning_pet = BattlePet.find_by_id(winning_pet_id.present? ? winning_pet_id : -1)	
		if(winning_pet.present?)
			winning_pet.won = winning_pet.won + 1 unless is_training
			winning_pet.experience = winning_pet.experience + (winner_experience.present? ? winner_experience : 0)
			winning_pet.level_up
			winning_pet.save
		end

		loser = Account.find_by_id(user1_id != winning_user_id ? user1_id : user2_id)
		if(loser.present?)
			
			loser.lost = loser.lost + 1 unless is_training
			loser.experience = loser.experience + (loser_experience.present?  ? loser_experience :  0)
			loser.level_up
			loser.save

		end

		losing_pet = BattlePet.find_by_id(pet1_id != winning_pet_id ? pet1_id : pet2_id)
		if(losing_pet.present?)

			losing_pet.lost = losing_pet.lost + 1 unless is_training
			losing_pet.experience = losing_pet.experience + (loser_experience.present? ? loser_experience : 0)
			losing_pet.level_up

			if play_for_keeps && winner.present? && winner.id >= 0
				losing_pet.previous_owner_id = losing_pet.account_id
  				losing_pet.account_id = winner.id
			end  

			losing_pet.save
		end

		self.save

  	end

	def self.get_battle_from_response data
		id = data[:original_id]
		battle = Battle.find_by_id(id)

		return nil if !battle.present?

		battle.battled_on = data[:battled_on]
		battle.winning_pet_id = data[:winning_pet_id]
		battle.winning_user_id = data[:winning_user_id]
		battle.is_tie = data[:is_tie]
		battle.status = data[:status]
		
		battle.save
		battle
	end

	def self.create_training_battle battle_pet, arena_id
		battle = Battle.new
	    battle.name = "Training"
	    battle.call_auth_code = SecureRandom.uuid
	    battle.arena_id = arena_id
	    battle.user1_id = battle_pet.account_id
	    battle.user2_id = -1
	    battle.pet1_id = battle_pet.id
	    battle.pet2_id = -1
	    battle.battle_game_id = 1
	    battle.winner_gold = 25
	    battle.winner_experience = 100
	    battle.loser_experience = 10
	    battle.status = "accepted"
	    battle.updated_by = battle_pet.account_id
	    battle.created_by = battle_pet.account_id
	    battle.save
	    battle
	end

end