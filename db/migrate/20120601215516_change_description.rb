class ChangeDescription < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.change :description, :text , :limit => 4096
    end
  end

  def down
    change_table :events do |t|
      t.change :description, :string, :limit => 255
    end
  end
end
