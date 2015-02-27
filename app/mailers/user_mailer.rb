class UserMailer < ActionMailer::Base

  def driver_created(user)
    
    @user = user

    mail(to: user.email,
      from: 'will@driverhunt.com',
      subject: 'Welcome to Driver Hunt'
    )

  end

end