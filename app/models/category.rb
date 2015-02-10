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
  has_many :users
  has_many :jobs
end
