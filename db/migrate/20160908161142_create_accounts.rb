class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :about
      t.integer :user_id
      t.string :email
      t.string :image
      t.string :permission
      t.string :status
      t.integer :level, default: 1, null: false
      t.integer :experience, default: 0, null: false
      t.integer :gold, default: 0, null: false
      t.integer :won, default: 0, null: false
      t.integer :lost, default: 0, null: false
      t.integer :tied, default: 0, null: false
      t.string :town
      t.string :planet
      t.string :galaxy
      t.integer :updated_by
      t.integer :created_by

      t.timestamps
    end
  end
end
