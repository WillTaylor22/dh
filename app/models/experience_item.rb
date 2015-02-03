require 'action_view'
include ActionView::Helpers::DateHelper

class ExperienceItem < ActiveRecord::Base
  belongs_to :user

  def end_date_or_present
    return 'Present' if current?
    end_date.strftime("%b %Y")
  end

  def timespan
    return distance_of_time_in_words_to_now(start_date) if current?
    return '1 month' if end_date - start_date < 1.month
    return distance_of_time_in_words(start_date, end_date)
  end
end
