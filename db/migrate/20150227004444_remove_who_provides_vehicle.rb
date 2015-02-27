class RemoveWhoProvidesVehicle < ActiveRecord::Migration
  def change
    remove_column :users, :who_provides_vehicle
  end
end
