class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.belongs_to :user, index: true
      t.string :name, :null => false
      t.text :description
      t.boolean :employer_provides_vehicle

      t.timestamps
    end
  end
end
