ActiveAdmin.register Job do

  menu priority: 2

  permit_params :user_id, :name, :description, :employer_provides_vehicle,
    :postcode, :latitude, :longitude, :summary, :rate_hourly_pounds, :rate_hourly_pence, 
    :rate_commission_pounds, :rate_commission_pence, :rate_not_included, :rate_max, :rate_min, 
    :rate_interval, :notes, :category_id, day_ids: [], shiftslot_ids: []

  form do |f|
    f.semantic_errors # shows errors on :base
    if f.object.errors.size >= 1
      f.inputs "Errors" do
        f.object.errors.full_messages.join('|')
      end
    end
    f.inputs "User Info" do         # builds an input field for every attribute
      f.input :user
      f.input :category_id,
        :label => 'Category', 
        :as => :select, 
        :collection => Category.all.map{|c| [c.name_of_user, c.id]}
      f.input :employer_provides_vehicle
      f.input :name
      f.input :description
      f.input :postcode
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
      f.input :notes
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons

  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
