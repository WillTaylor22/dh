class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :buyer_id
      t.integer :driver_id
      t.string :state
      t.timestamps
    end

    add_index :purchases, :buyer_id
    add_index :purchases, :driver_id

  end
end
