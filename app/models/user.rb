class User < ActiveRecord::Base

  ###### LOGIN ###

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login], :omniauth_providers => [:facebook]

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login, :crop_x, :crop_y, :crop_w, :crop_h

  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.first_name + auth.info.last_name + Devise.friendly_token[0,5]
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password = Devise.friendly_token[0,20]
    end
  end

  # user.name = auth.info.name   # assuming the user model has a name
  # user.image = auth.info.image # assuming the user model has an image


  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end


  ###### END LOGIN ###

  ###### PROFILE ###

  before_save { |user|
    user.username = user.username.downcase
    # user.first_name = nil if user.first_name = ""
    # user.last_name = nil if user.last_name = ""
    # user.summary = nil if user.summary = ""
    # user.long_description = nil if user.long_description = ""
  }

  # Getting latitude and longitude

  # It's currently saving all of the user, each time.
  geocoded_by :postcode
  after_validation :geocode
  reverse_geocoded_by :latitude, :longitude do |user,results|
    if geo = results.first
      user.city    = geo.city
      user.country = geo.country_code
    end
  end
  after_validation :reverse_geocode  # auto-fetch address

  mount_uploader :photo, PhotoUploader

  after_update :crop_avatar

  def crop_avatar
    photo.recreate_versions! if crop_x.present?
  end

  ###### END PROFILE ###

end
