class QualificationItem < ActiveRecord::Base
  belongs_to :user

  def end_date_or_present
    return 'Present' if current?
    end_date.strftime("%Y")
  end
end
