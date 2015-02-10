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
  acts_as_taggable_on :skills
  acts_as_mappable lng_column_name: :longitude, lat_column_name: :latitude

  geocoded_by :postcode #Fix!
  after_validation :geocode

  # def geocode
  #   geocoded = Geokit::Geocoders::GoogleGeocoder.geocode postcode
  #   latitude = geocoded.lat
  #   longitude = geocoded.lng
  # end
  # reverse_geocoded_by :latitude, :longitude do |user,results|
  #   if geo = results.first
  #     user.city    = geo.city
  #     user.country = geo.country_code
  #   end
  # end
  # after_validation :reverse_geocode  # auto-fetch address

  def distance_from_user(user)
    if user.latitude
      distance = distance_from([user.latitude, user.longitude])
      if distance == nil
        return nil
      else
        value = distance.to_s[0..3] if distance >= 1000
        value = distance.to_s[0..2] if distance >= 100
        value = distance.to_s[0..1] if distance >= 10
        value = distance.to_s[0..2] if distance < 10
      end
      return "#{value} miles"
    end
  end

  # Gives raw value
  def distance(user)
    if user.latitude && latitude
      distance_from([user.latitude, user.longitude])
    else
      99999
    end
  end

  def bearing_from_user(user)
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

  # searchable do
  #   text :name, :description, :boost => 4
  #   text :category, :skill_list
  #   time :created_at
  #   latlon(:location) { Sunspot::Util::Coordinates.new(latitude, longitude) }
  # end


end
