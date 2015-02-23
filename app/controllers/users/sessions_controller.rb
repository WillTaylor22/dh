class Users::SessionsController < Devise::SessionsController
  clear_respond_to
  respond_to :json, :html, :js
  before_action :redirect_if_not_signed_in

  # Whole bunch of actions here that aren't being shown.
  # TODO: Edit the "CREATE" action for the route of logging in after creating a job.
  #       Applies to mobile and main

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    # respond_with resource, location: after_sign_in_path_for(resource)
    if !user_signed_in?
      if params[:mobile]
        redirect_to m_signup_after_job_post_path(job: @job.id) and return
      else
        redirect_to post_job_path(@job)
      end
    else
      stored_location_for(resource) ||
        if params[:mobile] # post-Job path
          if params[:job]
            redirect_to m_dashboard_path and return   # TODO: Add job anchor to this.
          else
            redirect_to m_dashboard_path
          end
        else
          if params[:job] # post-Job path
            redirect_to job_path(@job)     # TODO: Test this.
          else
            redirect_to dashboard_path
          end
        end
    end
  end

  private

  def redirect_if_not_signed_in
    if !user_signed_in?
      flash[:notice] = "Could not sign in."
      redirect_to root_path
    end
  end

end
