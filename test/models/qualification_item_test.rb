# == Schema Information
#
# Table name: qualification_items
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  qualification_title :string(255)
#  location            :string(255)
#  start_date          :datetime
#  end_date            :datetime
#  current             :boolean
#  created_at          :datetime
#  updated_at          :datetime
#

require 'test_helper'

class QualificationItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
