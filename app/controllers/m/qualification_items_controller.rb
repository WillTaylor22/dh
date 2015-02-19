class M::QualificationItemsController < MController
  before_action :set_qualification_item, only: [:edit, :update, :destroy]
  respond_to :html

  def new
    @qualification_item = QualificationItem.new
    respond_with(@qualification_item)
  end

  def edit
  end

  def update
    @qualification_item.update(job_params)
    redirect_to m_profile_path(anchor: 'resume')
  end

  def destroy
    @qualification_item.destroy
    redirect_to m_profile_path(anchor: 'resume')
  end

  private

  def set_qualification_item
    @qualification_item = QualificationItem.find(params[:id])
  end

end