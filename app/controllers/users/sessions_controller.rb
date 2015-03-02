class Users::SessionsController < Devise::SessionsController
  clear_respond_to
  respond_to :json, :html, :js

  layout 'outside'
  # before_action :redirect_if_not_signed_in

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    # respond_with resource, location: after_sign_in_path_for(resource)
    if !user_signed_in?
      # All handled by warden.

      # if params[:mobile]
      #   render 'm/signup_after_job_post', layout: 'mobile' # m_signup_after_job_post_path(resource, job: params[:job_id])
      #   # redirect_to m_signup_after_job_post_path(job: @job.id) and return
      # else
      #   redirect_to post_job_path(@job)
      # end
    else

      if params[:job_id]
        resource.hunter = true
        resource.save
        @job = Job.assign_user_to_job(params[:job_id], resource)
        JobMailer.job_created(@job).deliver      
      end
      
      stored_location_for(resource) ||
        if params[:mobile] # post-Job path
          if params[:job_id]
            redirect_to m_dashboard_path and return   # TODO: Add job anchor to this.
          else
            redirect_to m_dashboard_path
          end
        else
          if params[:job_id] # post-Job path
            redirect_to job_path(@job)     # TODO: Test this.
          else
            redirect_to dashboard_path
          end
        end
    end
  end

  # private
  # 
  # def redirect_if_not_signed_in
  #   if params[:mobile] && params[:job_id]
  #     render 'm/signup_after_job_post', layout: 'mobile' # m_signup_after_job_post_path(resource, job: params[:job_id])
  #     # redirect_to m_signup_after_job_post_path(job: @job.id) and return
  #   end
  #   if !user_signed_in?
  #     flash[:notice] = "Could not sign in."
  #     redirect_to root_path
  #   end
  # end

end
