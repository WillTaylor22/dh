class QualificationItemsController < ApplicationController
  before_action :set_qualification_item, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @qualification_items = QualificationItem.all
    respond_with(@qualification_items)
  end

  def show
    respond_with(@qualification_item)
  end

  def new
    @qualification_item = QualificationItem.new
    respond_with(@qualification_item)
  end

  def edit
  end

  def create
    @qualification_item = QualificationItem.new(qualification_item_params)
    @qualification_item.save
    redirect_to redirect_path
  end

  def update
    @qualification_item.update(qualification_item_params)
    redirect_to redirect_path
  end

  def destroy
    @qualification_item.destroy
    redirect_to redirect_path
  end

  # These two actions are the ajax ones used in the profile
  def add
    @qualification_item = QualificationItem.new
  end

  def change
    @id = params[:id]
    @qualification_item = QualificationItem.find(@id.to_i)
  end

  private
    def set_qualification_item
      @qualification_item = QualificationItem.find(params[:id])
    end

    def qualification_item_params
      params.require(:qualification_item).permit(:user_id, :qualification_title, :location, :start_date, :end_date, :current)
    end
    
    def redirect_path
      if params[:mobile]
        m_profile_path(:anchor => 'resume')
      else
        user_path(current_user.username, :anchor => 'resume')
      end
    end

end
