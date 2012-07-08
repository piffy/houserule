class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.integer :group_id
      t.integer :user_id
      t.boolean :is_visible, :default => true
      t.boolean :is_banned, :default => false
      t.boolean :gets_email, :default => true

    end
    add_index :interests, :user_id
    add_index :interests, :group_id
    add_index :interests, [:user_id, :group_id], unique: true
  end
end
