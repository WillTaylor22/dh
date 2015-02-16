class Admin::JobsController < AdminController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:create]

  respond_to :html

  def index
    @jobs = Job.all
    respond_with(:admin, @jobs)
  end

  def show
    respond_with(:admin, @job)
  end

  def new
    @job = Job.new
    respond_with(:admin, @job)
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    @job.summary = job_params[:category_id] ? @job.category.name_of_user : params[:other_category] 
    @job.skill_list.add(params[:job][:skill_list])
    @job.save
    if params[:facebook] == 'true'
      redirect_to user_omniauth_authorize_path(:facebook, job_id: @job.id) and return 
    end
    respond_with(:admin, @job)
  end

  def update
    @job.update(job_params)
    respond_with(:admin, @job)
  end

  def destroy
    @job.destroy
    respond_with(:admin, @job)
  end

  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:category, :category_id, :other_category,
       :user_id, :name, :description, :employer_provides_vehicle, :postcode,
        :skill_list, :facebook, :skill_list, :rate_not_included, :rate_hourly_pounds,
        :rate_hourly_pence, :rate_commission_pounds, :rate_commission_pence,
        :rate_min, :rate_max, :rate_interval, :shiftslot_ids => [],
        :day_ids => [])
    end
end
