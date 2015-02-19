class ExperienceItemsController < ApplicationController
  before_action :set_experience_item, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @experience_items = ExperienceItem.all
    respond_with(@experience_items)
  end

  def show
    respond_with(@experience_item)
  end

  def new
    @experience_item = ExperienceItem.new
    respond_with(@experience_item)
  end

  def edit
  end

  def create
    @experience_item = ExperienceItem.new(experience_item_params)
    @experience_item.save
    redirect_to redirect_path
  end

  def update
    @experience_item.update(experience_item_params)
    redirect_to redirect_path
  end

  def destroy
    @experience_item.destroy
    redirect_to redirect_path
  end

  def add
    @experience_item = ExperienceItem.new
  end

  def change
    @id = params[:id]
    @experience_item = ExperienceItem.find(@id.to_i)
  end

  private
    def set_experience_item
      @experience_item = ExperienceItem.find(params[:id])
    end

    def experience_item_params
      params.require(:experience_item).permit(:user_id, :job_title, :location, :description, :start_date, :end_date, :current)
    end

    def redirect_path
      if params[:mobile]
        m_profile_path(:anchor => 'resume')
      else
        user_path(current_user.username, :anchor => 'resume')
      end
    end
end
