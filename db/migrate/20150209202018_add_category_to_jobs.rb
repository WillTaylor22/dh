class AddCategoryToJobs < ActiveRecord::Migration
  def change
    add_reference :jobs, :category, index: true
  end
end
