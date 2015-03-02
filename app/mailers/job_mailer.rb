class JobMailer < ActionMailer::Base

  def job_created(job)

    @job = job
    @user = job.user

    require 'mail'
    address = Mail::Address.new 'will@driverhunt.com' # ex: "john@example.com"
    address.display_name = 'Driver Hunt' # ex: "John Doe"
    # Set the From or Reply-To header to the following:
    from_address = address.format

    mail(to: @user.email,
      from: from_address,
      subject: 'Driver Hunt Job Posted'
    )

  end

end