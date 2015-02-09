class CreateProfileviews < ActiveRecord::Migration
  def change
    create_table :profileviews do |t|
      t.integer :viewer_id
      t.integer :viewee_id

      t.timestamps
    end

    add_index :profileviews, :viewer_id
    add_index :profileviews, :viewee_id
  end
end
