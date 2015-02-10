# == Schema Information
#
# Table name: purchases
#
#  id         :integer          not null, primary key
#  buyer_id   :integer
#  driver_id  :integer
#  state      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
