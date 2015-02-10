# == Schema Information
#
# Table name: experience_items
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  job_title   :string(255)
#  location    :string(255)
#  description :string(255)
#  start_date  :datetime
#  end_date    :datetime
#  current     :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class ExperienceItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
