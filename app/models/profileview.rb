class Profileview < ActiveRecord::Base
  belongs_to :viewer, :foreign_key => :viewer_id, class_name: 'User'
  belongs_to :viewee, :foreign_key => :viewee_id, class_name: 'User'
end
