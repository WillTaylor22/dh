# == Schema Information
#
# Table name: profileviews
#
#  id         :integer          not null, primary key
#  viewer_id  :integer
#  viewee_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Profileview < ActiveRecord::Base
  belongs_to :viewer, :foreign_key => :viewer_id, class_name: 'User'
  belongs_to :viewee, :foreign_key => :viewee_id, class_name: 'User'
end
