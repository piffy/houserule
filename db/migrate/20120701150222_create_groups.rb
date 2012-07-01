class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.string :location
      t.string :website_url
      t.string :image_url

      t.timestamps
    end
    add_index :groups, :name, unique: true
  end
end
