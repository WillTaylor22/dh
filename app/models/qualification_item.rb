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

class QualificationItem < ActiveRecord::Base
  belongs_to :user

  def end_date_or_present
    return 'Present' if current?
    end_date.strftime("%Y")
  end
end
