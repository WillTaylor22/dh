class AddRateRangeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :rate_max, :integer
    add_column :jobs, :rate_min, :integer
    add_column :jobs, :rate_interval, :string
    remove_column :jobs, :rate_other
  end
end
