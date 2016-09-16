class CreateArenas < ActiveRecord::Migration[5.0]
  def change
    create_table :arenas do |t|
      t.string :name
      t.string :description
      t.string :rated
      t.string :url
      t.integer :port
      t.integer :updated_by
      t.integer :created_by

      t.timestamps
    end


    add_index :arenas, :name, :name => 'arenas_name_idx'
    add_index :arenas, :rated, :name => 'arenas_rated_idx'
  end
end
