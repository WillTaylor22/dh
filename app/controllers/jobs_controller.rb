class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @jobs = Job.all
    respond_with(@jobs)
  end

  def show
    respond_with(@job)
  end

  def new
    @job = Job.new
    respond_with(@job)
  end

  def edit
  end

  def create
    puts "params"
    puts params
    @job = Job.new(job_params)
    @job.category = params[:other_category] if job_params[:category] == 'Other'
    @job.skill_list.add(params[:job][:skill_list])
    @job.save
    respond_with(@job)
  end

  def update
    @job.update(job_params)
    respond_with(@job)
  end

  def destroy
    @job.destroy
    respond_with(@job)
  end

  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:category, :other_category, :user_id, 
        :name, :description, :employer_provides_vehicle, :postcode,
        :skill_list)
    end
end
