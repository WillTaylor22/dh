class AddCategoryToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :category, index: true
  end
end
