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

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
