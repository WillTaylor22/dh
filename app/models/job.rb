class Job < ActiveRecord::Base
  belongs_to :user

  geocoded_by :postcode
  after_validation :geocode
  # reverse_geocoded_by :latitude, :longitude do |user,results|
  #   if geo = results.first
  #     user.city    = geo.city
  #     user.country = geo.country_code
  #   end
  # end
  # after_validation :reverse_geocode  # auto-fetch address

end
