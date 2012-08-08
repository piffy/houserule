class AddInviteOnlyAndLockReservationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :invite_only, :boolean, :default => false
    add_column :events, :reservation_locked, :boolean , :default => false
  end
end
