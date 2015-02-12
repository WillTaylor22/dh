class CreateJobsShiftslots < ActiveRecord::Migration
  def change
    create_table :jobs_shiftslots, :id => false do |t|
      t.references :job
      t.references :shiftslot
    end
    add_index :jobs_shiftslots, [:job_id, :shiftslot_id], :unique => true
  end
end
