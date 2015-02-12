class AddActivityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activity_level, :string
  end
end
