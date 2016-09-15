# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

user1 = User.create!({email: 'admin@battle.com', current_sign_in_at: DateTime.now.new_offset(0), current_sign_in_ip: '127.0.0.1', password:'Test1234!', encrypted_password: '$2a$11$3erLW.rivEkOhLaLUb7myuZhHsJBnbAHC9nprWYEfaEyZUD1B9oMu'}) 
account1 = Account.find_by(user_id:user1.id)
account1.permission = 'admin'
account1.save

user2 = User.create!({email: 'admin2@battle.com', current_sign_in_at: DateTime.now.new_offset(0), current_sign_in_ip: '127.0.0.1', password:'Test1234!', encrypted_password: '$2a$11$3erLW.rivEkOhLaLUb7myuZhHsJBnbAHC9nprWYEfaEyZUD1B9oMu'}) 
account2 = Account.find_by(user_id:user2.id)
account2.permission = 'admin'
account2.save

user3 = User.create!({email: 'user@battle.com', current_sign_in_at: DateTime.now.new_offset(0), current_sign_in_ip: '127.0.0.1', password:'Test1234!', encrypted_password: '$2a$11$3erLW.rivEkOhLaLUb7myuZhHsJBnbAHC9nprWYEfaEyZUD1B9oMu'}) 
account3 = Account.find_by(user_id:user3.id)
account3.permission = 'admin'
account3.save

user4 = User.create!({email: 'user2@battle.com', current_sign_in_at: DateTime.now.new_offset(0), current_sign_in_ip: '127.0.0.1', password:'Test1234!', encrypted_password: '$2a$11$3erLW.rivEkOhLaLUb7myuZhHsJBnbAHC9nprWYEfaEyZUD1B9oMu'}) 
account4 = Account.find_by(user_id:user4.id)
account4.permission = 'admin'
account4.save

 arena_url = "https://localhost:3001/"
 arena_port = "3000"

if Rails.env.production? 
 arena_url = "https://desolate-sierra-84556.herokuapp.com/"
 arena_port = "443"
end

arena1 = Arena.create!({name:"Bob's Battle Emporium", rated:"PG", url:arena_url, port:arena_port, updated_by:account1.id, created_by:account1.id})
arena2 = Arena.create!({name:"Crazy Al's Arena", rated:"PG", url:arena_url, port:arena_port, updated_by:account1.id, created_by:account1.id})

battle_pet1 = BattlePet.create!({name: 'Achoo', about:'Sneeze attack!', status:'active', strength:3,  agility:6, wit:3, speed:6, wisdom:1, intelligence:2, magic:5, chi:2, healing_power:1, account_id:account1.id, updated_by:account1.id, created_by:account1.id})
battle_pet2 = BattlePet.create!({name: 'Bonkers', about:'Berzerker attack!', status:'active', strength:6,  agility:3, wit:1, speed:6, wisdom:1, intelligence:1, magic:5, chi:2, healing_power:1, account_id:account1.id, updated_by:account1.id, created_by:account1.id})

battle_pet3 = BattlePet.create!({name: 'Larry', about:'Surprise attack!', status:'active', strength:2,  agility:6, wit:6, speed:6, wisdom:4, intelligence:5, magic:2, chi:2, healing_power:2, account_id:account2.id, updated_by:account2.id, created_by:account2.id})
battle_pet4 = BattlePet.create!({name: "Achoo's Brother", about:'Cough attack!', status:'active', strength:5,  agility:6, wit:3, speed:6, wisdom:1, intelligence:2, magic:5, chi:2, healing_power:1, account_id:account3.id, updated_by:account3.id, created_by:account3.id})

#add some battle invites
battle1 = Battle.new
battle1.name = "Battle One"
battle1.call_auth_code = SecureRandom.uuid
battle1.arena_id = arena1.id
battle1.user1_id = account1.id
battle1.user2_id = account2.id
battle1.pet1_id = battle_pet1.id
battle1.pet2_id = battle_pet3.id
battle1.battle_game_id = 1
battle1.winner_gold = 25
battle1.winner_experience = 100
battle1.loser_experience = 10
battle1.status = "invited"
battle1.updated_by = account1.id
battle1.created_by = account1.id
battle1.save


battle2 = Battle.new
battle2.name = "Battle Two"
battle2.call_auth_code = SecureRandom.uuid
battle2.arena_id = arena1.id
battle2.user1_id = account1.id
battle2.user2_id = account2.id
battle2.pet1_id = battle_pet1.id
battle2.pet2_id = battle_pet3.id
battle2.battle_game_id = 1
battle2.winner_gold = 50
battle2.winner_experience = 125
battle2.loser_experience = 5
battle2.status = "invited"
battle2.updated_by = account1.id
battle2.created_by = account1.id
battle2.save

battle3 = Battle.new
battle3.name = "Battle Three"
battle3.call_auth_code = SecureRandom.uuid
battle3.arena_id = arena1.id
battle3.user1_id = account2.id
battle3.user2_id = account1.id
battle3.pet1_id = battle_pet3.id
battle3.pet2_id = battle_pet1.id
battle3.battle_game_id = 1
battle3.winner_gold = 25
battle3.winner_experience = 100
battle3.loser_experience = 10
battle3.status = "invited"
battle3.updated_by = account2.id
battle3.created_by = account2.id
battle3.save

#add an old battle
old_battle = Battle.new
old_battle.name = "Legendary Battle"
old_battle.call_auth_code = SecureRandom.uuid
old_battle.arena_id = arena1.id
old_battle.user1_id = account2.id
old_battle.user2_id = account1.id
old_battle.pet1_id = battle_pet3.id
old_battle.pet2_id = battle_pet1.id
old_battle.battled_on = DateTime.now.new_offset(0)
old_battle.winning_user_id = 2
old_battle.winning_pet_id = 3
old_battle.play_for_keeps = false
old_battle.is_tie = false
old_battle.battle_game_id = 1
old_battle.winner_gold = 25
old_battle.winner_experience = 100
old_battle.loser_experience = 10
old_battle.status = "legendary"
old_battle.updated_by = account2.id
old_battle.created_by = account2.id
old_battle.save
