class AddDaysToJobs < ActiveRecord::Migration
  def change

    create_table :days do |t|
      t.string :name
    end

    create_table :days_jobs, :id => false do |t|
      t.references :day
      t.references :job
    end

    add_index :days_jobs, [:day_id, :job_id], :unique => true

  end
end
