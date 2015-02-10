# == Schema Information
#
# Table name: jobs
#
#  id                        :integer          not null, primary key
#  user_id                   :integer
#  name                      :string(255)      not null
#  description               :text
#  employer_provides_vehicle :boolean
#  created_at                :datetime
#  updated_at                :datetime
#  category                  :string(255)
#  postcode                  :string(255)
#  latitude                  :float
#  longitude                 :float
#

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
