class AddLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :postcode, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
