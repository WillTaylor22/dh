class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :vehicle
      t.string :name_of_user
      t.text :description

      t.timestamps
    end
  end
end
