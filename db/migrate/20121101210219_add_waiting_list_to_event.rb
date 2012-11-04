class AddWaitingListToEvent < ActiveRecord::Migration
  def change
    add_column :events, :waiting_list, :integer, :default => 0
  end
end
