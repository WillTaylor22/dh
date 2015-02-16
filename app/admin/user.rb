ActiveAdmin.register User do

  scope :drivers
  scope :hunters

  menu priority: 1

  index do
    column :full_name
    column :phone_number
    column :email
    column :category
    column "Joined", :created_at
    actions
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