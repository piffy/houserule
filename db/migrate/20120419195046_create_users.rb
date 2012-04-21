class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :nick
      t.string :description
      t.string :location

      t.timestamps
    end
  end
end
