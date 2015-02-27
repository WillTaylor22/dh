class UserMailer < ActionMailer::Base

  def driver_created(user)
    
    @user = user

    require 'mail'
    address = Mail::Address.new 'will@driverhunt.com' # ex: "john@example.com"
    address.display_name = 'Driver Hunt' # ex: "John Doe"
    # Set the From or Reply-To header to the following:
    from_address = address.format

    mail(to: user.email,
      from: from_address,
      subject: 'Welcome to Driver Hunt'
    )

  end

end