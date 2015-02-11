class ProfileController < ApplicationController

  before_action :authenticate_user!
  layout false

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