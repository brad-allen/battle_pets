class CreateBattles < ActiveRecord::Migration[5.0]
  def change
    create_table :battles do |t|
      t.string :name
      t.string :description
      t.string :call_auth_code
      t.integer :arena_id
      t.integer :user1_id
      t.integer :user2_id
      t.integer :pet1_id
      t.integer :pet2_id
      t.datetime :battled_on
      t.integer :winning_pet_id
      t.integer :winning_user_id
      t.integer :battle_game_id
      t.string :status
      t.decimal :score
      t.boolean :play_for_keeps, default: false, null: false
      t.boolean :is_tie, default: false, null: false
      t.integer :winner_experience, default: 0, null: false
      t.integer :loser_experience, default: 0, null: false
      t.integer :winner_gold, default: 0, null: false
      t.integer :updated_by
      t.integer :created_by

      t.timestamps
    end


    add_index :battles, :name, :name => 'battles_name_idx'
    add_index :battles, :call_auth_code, :name => 'battles_call_auth_code_idx'
    add_index :battles, :user1_id, :name => 'battles_user1_id_idx'
    add_index :battles, :user2_id, :name => 'battles_user2_id_idx'
    add_index :battles, :pet1_id, :name => 'battles_pet1_id_idx'
    add_index :battles, :pet2_id, :name => 'battles_pet2_id_idx'
    add_index :battles, :battled_on, :name => 'battles_battled_on_idx'

  end
end
