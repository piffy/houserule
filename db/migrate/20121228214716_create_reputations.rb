class CreateReputations < ActiveRecord::Migration
  def change
    create_table :reputations do |t|
      t.integer :user_id
      t.integer :participations, :default => 0
      t.integer :positive_fb, :default => 0
      t.integer :negative_fb, :default => 0
      t.integer :organized, :default =>0
      t.integer :archived, :default => 0
    end
    add_index :reputations, :user_id, unique: true
  end

end
