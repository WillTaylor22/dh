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

class Job < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :shiftslots
  has_and_belongs_to_many :days
  acts_as_taggable_on :skills

  before_save :update_summary

  geocoded_by :postcode #Fix!
  after_validation :geocode

  acts_as_mappable lng_column_name: :longitude, lat_column_name: :latitude

  #### JOB CREATE ###

  def self.assign_user_to_job(job_id, user)
    @job = self.find(job_id)
    @job.user = user
    @job.save
    @job
  end

  ### end JOB CREATE ###

  #### JOB DETAIL ###

  def distance_from_user(user)
    return "Unavailable" unless user && user.latitude && self.latitude
    distance = distance_from([user.latitude, user.longitude])
    value = distance.to_s[0..3] if distance >= 1000
    value = distance.to_s[0..2] if distance >= 100
    value = distance.to_s[0..1] if distance >= 10
    value = distance.to_s[0..2] if distance < 10
    value = 0 if distance == 0
    ActionController::Base.helpers.pluralize(value, 'mile')
  end

  # Gives raw value
  def distance(user)
    return nil unless user.latitude && latitude
    distance_from([user.latitude, user.longitude])
  end

  def bearing_from_user(user)
    return nil if (!latitude || (latitude == user.latitude && longitude == user.longitude))
    # bearing = (([latitude, longitude]).heading_to([user.latitude, user.longitude]) + 180)%360
    bearing = (bearing_to([user.latitude, user.longitude]) + 180)%360

    string = 'North' if bearing >= 337.5 && bearing < 22.5
    string = 'North East' if bearing >= 22.5 && bearing < 67.5
    string = 'East' if bearing >= 67.5 && bearing < 112.5
    string = 'South East' if bearing >= 112.5 && bearing < 157.5
    string = 'South' if bearing >= 157.5 && bearing < 202.5
    string = 'South West' if bearing >= 202.5 && bearing < 247.5
    string = 'West' if bearing >= 247.5 && bearing < 292.5
    string = 'North West' if bearing >= 292.5 && bearing < 382.5

    string
  end

  ### end JOB DETAILS ###

  ### JOB SEARCH ###

  def table_name
    string = self.name
    string += " - " + self.summary if self.summary
    string += " - " + self.description if self.description
    return string[0...100] + "..." if string.length > 100
    string
  end

  def self.filter_by_params params, user
    @jobs = self.all
    if params[:category]
      category = Category.where("lower(vehicle) = ?", params[:category].downcase).first
      @jobs = @jobs.where(category: category) if category.present?
    end
    if params[:age] && params[:age] != 'all'
      time_from = 1.month.ago if params[:age] == 'month'
      time_from = 1.week.ago if params[:age] == 'week'
      time_from = 1.day.ago if params[:age] == 'day'
      @jobs = @jobs.where('created_at > ?', time_from) 
    end
    if params[:max_distance] && params[:max_distance] != 'all'
      max_distance = 1 if params[:max_distance] == '1'
      max_distance = 3 if params[:max_distance] == '3'
      max_distance = 5 if params[:max_distance] == '5'
      max_distance = 10 if params[:max_distance] == '10'
      max_distance = 20 if params[:max_distance] == '20'
      @jobs = @jobs.within(max_distance, origin: user)
    end
    if params[:search] && params[:search] != ""
      params[:search].split.each do |query|
        @jobs = @jobs.where("name @@ :q or description @@ :q", q: "#{query}")
      end
    end
    if params[:sort] != 'date' && user.latitude # distance or default
      # default direction is ascending
      if params[:direction] == 'desc'      
        @jobs = @jobs.by_distance(origin: user).reverse_order
      else
        @jobs = @jobs.by_distance(origin: user)
      end
    end
    if params[:sort] == "date" || !user.latitude
      if params[:direction] == 'desc'      
        @jobs = @jobs.order(:created_at)
      else
        @jobs = @jobs.order(:created_at).reverse_order
      end
    end
    @jobs
  end

  ##### Email ####

  def list_of_days
    return "All" if days.length == 7 || days == nil
    days.map{|i| i.name}.join(", ")
  end

  def list_of_shifts
    return "All" if shiftslots.length == 4 || days == nil
    shiftslots.map{|i| i.name}.join(", ")
  end

  ##### End of email ####

  private
  def update_summary
    self.summary = category.name_of_user if !category.nil?
  end

end
