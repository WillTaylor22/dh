class AddDescriptionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :summary, :string
    add_column :users, :long_description, :text
  end
end
