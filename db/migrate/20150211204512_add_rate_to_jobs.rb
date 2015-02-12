class AddRateToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :rate_hourly_pounds, :integer
    add_column :jobs, :rate_hourly_pence, :integer
    add_column :jobs, :rate_commission_pounds, :integer
    add_column :jobs, :rate_commission_pence, :integer
    add_column :jobs, :rate_other, :text
    add_column :jobs, :rate_not_included, :boolean
  end
end
