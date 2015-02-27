ActiveAdmin.register User do

  scope :drivers
  scope :hunters

  menu priority: 1

  permit_params :first_name, :last_name, :username, :email, :phone_number,
    :activity_level, :summary, :long_description, :postcode, :password,
    :notes, category_ids: [], vehicle_ids: [], day_ids: [], shiftslot_ids: []


  index do
    column :full_name
    column :email
    column :phone_number
    column "Jobs Wanted" do |driver|
      driver.list_of_categories
    end
    column "Vehicles" do |driver|
      driver.list_of_vehicles
    end
    column "Days" do |driver|
      driver.days.map{|i| i.name[0..2]}.join(",")
    end
    column "Shifts" do |driver|
      driver.shiftslots.map{|i| i.name[0..2]}.join(",")
    end
    column :postcode
    column "Joined", :created_at
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    if f.object.errors.size >= 1
      f.inputs "Errors" do
        f.object.errors.full_messages.join('|')
      end
    end
    f.inputs "User Info" do         # builds an input field for every attribute
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :username
      f.input :password
      f.input :phone_number
      f.input :activity_level
      f.input :categories,
        :as => :select,
        :multiple => :true,
        :collection => Category.all.map{|i| [i.vehicle, i.id]},
        :input_html => { :class => "multiple-select" }
      f.input :vehicles,
        :as => :select,
        :multiple => :true,
        :collection => Category.all.map{|i| [i.vehicle, i.id]},
        :input_html => { :class => "multiple-select" }
      f.input :days,
        :as => :select,
        :multiple => :true,
        :collection => Day.all.map{|i| [i.name, i.id]},
        :input_html => { :class => "multiple-select" }
      f.input :shiftslots,
        :as => :select,
        :multiple => :true,
        :collection => Shiftslot.all.map{|i| [i.name, i.id]},
        :input_html => { :class => "multiple-select" }


      # f.input :category_id
      # f.input :summary
      # f.input :long_description
      # f.input :sign_in_count
      # f.input :created_at
      # f.input :updated_at
      f.input :postcode
      f.input :notes
      # f.input :latitude
      # f.input :longitude
      # f.input :city
      # f.input :country
      # f.input :photo
      # f.input :stripe_customer_id
      # f.input :valid_license
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  controller do

    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end

    def create
      if params[:user][:username].blank?
        params[:user][:username] = params[:user][:email]
      end
      if params[:user][:password].blank?
        params[:user][:password] = params[:user][:email]
        params[:user][:password_confirmation] = params[:user][:email]
      end
      super
      # customised_params = sign_up_params
      # customised_params["username"] = sign_up_params["email"].downcase
      # build_resource(customised_params)

      # resource.save
      # yield resource if block_given?
      # if resource.persisted?
      #   if resource.active_for_authentication?
      #     set_flash_message :notice, :signed_up if is_flashing_format?
      #     sign_up(resource_name, resource)
      #     respond_with resource, location: after_sign_up_path_for(resource)
      #   else
      #     set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
      #     expire_data_after_sign_in!
      #     respond_with after_inactive_sign_up_path_for(resource)
      #   end
      # else
      #   # Sign up failed
      #   clean_up_passwords resource
      #   set_minimum_password_length
      #   if params[:mobile]
      #     puts "in mobile"
      #     if params[:job_id] # = params[:job[ -> job path
      #       puts "in job"
      #       puts resource.to_yaml
      #       # redirect_to m_signup_after_job_post_path(resource, job: params[:job_id])
      #       render 'm/signup_after_job_post', layout: 'mobile' # m_signup_after_job_post_path(resource, job: params[:job_id])
      #     else
      #       puts "in not-job"
      #       redirect_to m_sign_in_path(resource)
      #     end
      #   else
      #     respond_with resource
      #   end
      # end
      # if params[:job_id]
      #   resource.hunter = true
      #   resource.save
      #   @job = Job.assign_user_to_job(params[:job_id], resource)
      # end
    end

  end

end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Permit_params allows an attribute to be changed.

  # permit_params :email
  # :encrypted_password
  # :reset_password_token,
  # :reset_password_sent_at,
  # :remember_created_at,
  # :sign_in_count,
  # :current_sign_in_at,
  # :last_sign_in_at,
  # :current_sign_in_ip,
  # :last_sign_in_ip,
  # :created_at,
  # :updated_at,
  # :username,
  # :provider,
  # :uid,
  # :first_name,
  # :last_name,
  # :summary,
  # :long_description,
  # :postcode,
  # :latitude,
  # :longitude,
  # :city,
  # :country,
  # :photo,
  # :stripe_customer_id,
  # :phone_number,
  # :category_id,
  # :activity_level,
  # :valid_license

  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end