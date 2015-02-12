class AddDaysAndShiftsToUser < ActiveRecord::Migration
  def change

    create_table :days_users, :id => false do |t|
      t.references :day
      t.references :user
    end

    add_index :days_users, [:day_id, :user_id], :unique => true

    create_table :shiftslots_users, :id => false do |t|
      t.references :shiftslot
      t.references :user
    end

    add_index :shiftslots_users, [:shiftslot_id, :user_id], :unique => true

  end
end
