class CreateQualificationItems < ActiveRecord::Migration
  def change
    create_table :qualification_items do |t|
      t.belongs_to :user
      t.string :qualification_title
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :current

      t.timestamps
    end
  end
end
