class M::PagesController < MController

  # require signup for inside
  respond_to :html
  layout 'mobile'

  def home
  end

  def sign_in
    resource ||= User.new
    respond_with(resource)
  end

  def signup_after_job_post
  end

  def onboarding
  end

  def privacy
  end

  def terms
  end

######

  def dashboard
  end

  def profile
    @experience_items = current_user.ordered_experience_items
    @qualification_items = current_user.ordered_qualification_items
  end

  def edit
  end

  def new_experience_item
  end

  def new_qualification_item
  end

  # Unless job.user, assign user

end
