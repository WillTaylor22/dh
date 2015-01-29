class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def facebook
    user = User.from_omniauth(request.env["omniauth.auth"])

    # puts "in facebook controller"
    # puts request.env["omniauth.auth"]
    # puts "***"
    # puts user

    if user.persisted?
      flash.notice =  "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      flash.notice =  "Facebook sign in failed. Please sign in with your email address."
      redirect_to root_url
    end
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when omniauth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
