class CreateShiftslots < ActiveRecord::Migration
  def change
    create_table :shiftslots do |t|
      t.string :name

      t.timestamps
    end
  end
end
