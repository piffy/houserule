class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :event_id
      t.integer :user_id
      t.boolean :pending, :default => true
      t.boolean :accepted,  :default => false
      t.datetime :valid_until
    end
    add_index :invitations, :user_id
    add_index :invitations, :event_id
    add_index :invitations, [:user_id, :event_id], unique: true
  end

end
