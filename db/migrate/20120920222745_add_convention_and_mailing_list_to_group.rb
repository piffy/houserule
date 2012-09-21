class AddConventionAndMailingListToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :is_convention, :boolean, :default => false
    add_column :groups, :mailing_list, :string
  end
end
