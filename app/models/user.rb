class User < ActiveRecord::Base

  ###### LOGIN ###

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login], :omniauth_providers => [:facebook]

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login, :crop_x, :crop_y, :crop_w, :crop_h, :photo

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


    puts "Getting user from omniauth"
    puts auth.info.to_yaml

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.first_name.downcase + auth.info.last_name.downcase + '-' + Devise.friendly_token[0,4].downcase
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password = Devise.friendly_token[0,20]
      # user.photo = "Banana"
      user.photo = (auth.info.image + "?type=large").gsub("­http","htt­ps")
    end

    # puts "output is:"
    # puts where(provider: auth.provider, uid: auth.uid).first
  end

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

  before_save { |user| user.username = user.username.downcase }
  before_save :normalize_blank_values


  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end

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

  has_many :experience_items, dependent: :destroy
  has_many :qualification_items, dependent: :destroy

  ###### END PROFILE ###

end
