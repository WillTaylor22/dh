class HomepageController < ApplicationController

  layout false

  def home
  end

  def post_job
    @job = Job.new
  end

  def help
  end

  def terms
  end

  def privacy
  end

end