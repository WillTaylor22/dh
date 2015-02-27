ActiveAdmin.register User do

  scope :drivers
  scope :hunters

  menu priority: 1

  permit_params :first_name, :last_name, :username, :email, :phone_number,
    :activity_level, :category_id, :summary, :long_description, :postcode,
    :notes


  index do
    column :full_name
    column :email
    column :phone_number
    column "Jobs" do |driver|
      driver.category.try(:vehicle)
    end
    column "Vehicles" do |driver|
      driver.vehicles.map{|i| i.vehicle}.join(",")
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
    f.inputs "User Info" do         # builds an input field for every attribute
      f.input :first_name
      f.input :last_name
      f.input :username
      f.input :email
      f.input :phone_number
      f.input :activity_level
      f.input :category_id
      f.input :summary
      f.input :long_description
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