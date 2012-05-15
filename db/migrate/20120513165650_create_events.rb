class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :system
      t.datetime   :begins_at
      t.string :duration
      t.string :description
      t.string :descr_short
      t.datetime :deadline
      t.integer :status
      t.string :location
      t.integer :max_player_num, :default => 0
      t.integer :min_player_num, :default => 0
      t.integer :user_id

      t.timestamps
    end
    add_index :events, :begins_at
    add_index :events, :name
    add_index :events, :user_id
  end
end
