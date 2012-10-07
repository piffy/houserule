class CreateGroupsEvents < ActiveRecord::Migration
  def change
    create_table :events_groups, :id => false do |t|
      t.references :group, :null => false
      t.references :event, :null => false
    end

    add_index(:events_groups, [:group_id, :event_id], :unique => true)
  end
end
