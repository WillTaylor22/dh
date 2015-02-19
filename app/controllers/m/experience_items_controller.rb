class M::ExperienceItemsController < MController
  before_action :set_experience_item, only: [:edit, :update, :destroy]
  respond_to :html

  def new
    @experience_item = ExperienceItem.new
    respond_with(@experience_item)
  end

  def edit
  end

  def update
    @experience_item.update(job_params)
    redirect_to m_profile_path(anchor: 'resume')
  end

  def destroy
    @experience_item.destroy
    redirect_to m_profile_path(anchor: 'resume')
  end

  private

  def set_experience_item
    @experience_item = ExperienceItem.find(params[:id])
  end

end