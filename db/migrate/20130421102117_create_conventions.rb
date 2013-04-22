class CreateConventions < ActiveRecord::Migration
  def change
    create_table :conventions do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.string :location
      t.string :website_url
      t.string :image_url
      t.string :facebook_url
      t.boolean :linked_event_check,  :default => false
      t.datetime :begin_date
      t.datetime :end_date

      t.timestamps
    end
    add_index :conventions, :name, unique: true
  end
end
