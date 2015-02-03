class PagesController < ApplicationController

  before_action :authenticate_user!

  def projects
  end

  def profile
    @user = User.find_by(:username => params[:username])
    @experience_items = @user.experience_items.where(current: true).order(start_date: :desc)
    @experience_items += @user.experience_items.where(current: false).order(end_date: :desc)
    @qualification_items = @user.qualification_items.where(current: true).order(start_date: :desc)
    @qualification_items += @user.qualification_items.where(current: false).order(end_date: :desc)
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

  def add_experience_item
    @experience_item = ExperienceItem.new
  end

  def edit_experience_item
    @id = params[:id]
    @experience_item = ExperienceItem.find(@id.to_i)
  end

  def add_qualification_item
    @qualification_item = QualificationItem.new
  end

  def edit_qualification_item
    @id = params[:id]
    @qualification_item = QualificationItem.find(@id.to_i)
  end

end
