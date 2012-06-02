class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :status

      t.timestamps
    end
    add_index :reservations,  [:user_id, :event_id], :unique => true
  end
end
