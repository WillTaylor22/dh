class AddSummaryToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :summary, :string
  end
end
