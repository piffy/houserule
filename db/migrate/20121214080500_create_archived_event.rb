class CreateArchivedEvent < ActiveRecord::Migration
  def up
    create_table :archived_events do |t|
      t.string :name
      t.string :system
      t.datetime   :begins_at
      t.string :duration
      t.text :description, :limit => 4000
      t.text :aftermath
      t.text :subscriber_list, :limit => 4000
      t.string :descr_short
      t.datetime :deadline
      #t.integer :status
      t.string :location
      t.integer :max_player_num, :default => 0
      t.integer :min_player_num, :default => 0
      t.integer :user_id
      t.timestamps
    end
  end

  def down
    drop_table :archived_events
  end
end
