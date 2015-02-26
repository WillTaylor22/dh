class AddWhoProvidesVehicleToUser < ActiveRecord::Migration
  def change
    add_column :users, :who_provides_vehicle, :string
  end
end
