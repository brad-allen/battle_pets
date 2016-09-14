class CreateBattlePets < ActiveRecord::Migration[5.0]
  def change
    create_table :battle_pets do |t|
      t.string :name
      t.string :about
      t.string :image
      t.integer :level, default: 1, null: false
      t.integer :experience, default: 0, null: false
      t.integer :won, default: 0, null: false
      t.integer :lost, default: 0, null: false
      t.integer :tied, default: 0, null: false
      t.string :town
      t.string :planet
      t.string :galaxy
      t.boolean :retired, default: false, null: false
      t.boolean :auto_accept_play_for_points_requests, default: false, null: false
      t.string :status
      t.integer :account_id
      t.integer :previous_owner_id
      t.integer :original_owner_id
      t.integer :strength, default: 0, null: false
      t.integer :agility, default: 0, null: false
      t.integer :wit, default: 0, null: false
      t.integer :speed, default: 0, null: false
      t.integer :wisdom, default: 0, null: false
      t.integer :intelligence, default: 0, null: false
      t.integer :magic, default: 0, null: false
      t.integer :chi, default: 0, null: false
      t.integer :healing_power, default: 0, null: false
      t.integer :updated_by
      t.integer :created_by

      t.timestamps
    end
  end
end
