class AddHunterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hunter, :boolean
  end
end
