class CreateExperienceItems < ActiveRecord::Migration
  def change
    create_table :experience_items do |t|
      t.belongs_to :user
      t.string :job_title
      t.string :location
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :current

      t.timestamps
    end
  end
end
