class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login], :omniauth_providers => [:facebook]

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

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
    puts "in from_omniauth"
    puts auth.to_yaml
    puts "*8*"
    puts auth.info.to_yaml

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      puts "in where"
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.first_name + auth.info.last_name + Devise.friendly_token[0,5]
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      puts user.to_yaml
      puts "*@£*@"
      puts "user.username"
      puts user.username
      puts user.id.to_s

    end
  end

      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image


  def self.new_with_session(params, session)
    puts "running new_with_session"
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
    puts "in password_required"
    super && provider.blank?
  end

end
