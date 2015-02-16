class HomepageController < ApplicationController

  layout :resolve_layout
  

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


  private

  def resolve_layout
    case action_name
    when "home", "help"
      false
    else
      "outside"
    end
  end

end