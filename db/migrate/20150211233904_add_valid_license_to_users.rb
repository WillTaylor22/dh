class AddValidLicenseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :valid_license, :boolean
  end
end
