class PagesController < ApplicationController

  before_action :authenticate_user!

  def projects
  end

  def profile
    @user = User.find_by(:username => params[:username])
  end

  def chat
  end

  def edit_name
  end

  def edit_summary
  end

  def edit_description
  end
  
  def edit_postcode
  end

  def upload_photo
  end

  def crop
  end

end
