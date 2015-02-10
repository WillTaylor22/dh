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

require 'test_helper'

class ProfileviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
