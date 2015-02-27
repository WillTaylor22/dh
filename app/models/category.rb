# == Schema Information
#
# Table name: categories
#
#  id           :integer          not null, primary key
#  vehicle      :string(255)
#  name_of_user :string(255)
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Category < ActiveRecord::Base
  has_many :jobs
  # has_many :users
  has_and_belongs_to_many :users_vehicles, :foreign_key => :vehicle_id
  has_and_belongs_to_many :categories_users

  #### JOB POST ###

  def self.job_name id
    return nil if id == "default" || !id
    cat = self.find(id)
    cat.present? ? cat.name_of_user.titleize + " Job" : nil
  end

  #### END JOB POST ###
end
