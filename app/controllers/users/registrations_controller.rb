class Users::RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :json, :html
  # before_filter :configure_sign_up_params, only: [:create]
  # before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    customised_params = sign_up_params
    customised_params["username"] = sign_up_params["email"].downcase
    build_resource(customised_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
    if params[:job_id]
      resource.hunter = true
      resource.save
      @job = Job.assign_user_to_job(params[:job_id], resource)
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super
    if params[:onboarding]
      if resource.category
        resource.summary = resource.category.name_of_user
      else
        resource.summary = params[:other_category]
      end
      resource.save!
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    if params[:user][:photo].present?
      :crop
    elsif !params[:onboarding] && params[:mobile]
      m_profile_path
    elsif params[:onboarding]
      if params[:mobile]
        m_dashboard_path
      else
        flash[:notice] = "Great! Here are the jobs near you."
        resource.category ? jobs_path(category: resource.category.vehicle) : jobs_path
      end
    else
      user_path resource.username
    end
  end

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end


  # The path used after sign up.
  # See also ajax used by homepage (to work with tabs)
  def after_sign_up_path_for(resource)
    # @job available if job was just created
    puts 'params'
    puts params
    if params[:mobile]
      if params[:hunter]
        m_dashboard_path
      else
        m_onboarding_path
      end
    else
      onboarding_path # Not used - redirect done in AJAX
    end
  end

  # def after_failed_sign_up_path_for(resource)
  #   puts "in after_failed_sign_up_path_for"
  #   if params[:mobile]
  #     resource # Todo: set this to go to mobile site
  #   else
  #     resource
  #   end
  # end


  def set_minimum_password_length
    if devise_mapping.validatable?
      @minimum_password_length = resource_class.password_length.min
    end
  end
end
