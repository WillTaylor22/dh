class PagesController < ApplicationController

  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def projects
  end

  def onboarding
  end

  def profile
    @user = User.find_by(:username => params[:username])

    # save the profileview
    unless current_user == @user
      pv = Profileview.find_or_create_by(viewee: @user, viewer: current_user) 
      pv.touch
    end

    @experience_items = @user.experience_items.where(current: true).order(start_date: :desc)
    @experience_items += @user.experience_items.where(current: false).order(end_date: :desc)
    @qualification_items = @user.qualification_items.where(current: true).order(start_date: :desc)
    @qualification_items += @user.qualification_items.where(current: false).order(end_date: :desc)
  end

  def chat
    @viewed = current_user.viewed
    @conversed_with = current_user.conversed_with
    @purchased = current_user.drivers
  end

  def drivers
    @search = User.search do
      fulltext params[:search]
    end
    @drivers = @search.results
  end

  def job
    @job = Job.find(params[:id])
  end

  def jobs
    @category = Category.where(vehicle: params[:category]) if params[:category]
    @category = Category.find(1)
    lat = current_user.latitude
    lng = current_user.longitude
    radius = params[:radius] || 800

    @search = Job.search do
      keywords params[:search] if params[:search]
      with(:location).in_radius(lat, lng, radius)

      order_by :created_at if (params[:sort] == 'created_at' && params[:direction] != 'desc')
      order_by(:created_at, :desc) if (params[:sort] == 'created_at' && params[:direction] == 'desc')
      order_by_geodist(:location, lat, lng) if params[:sort] == 'distance'


      paginate :page => params[:page], :per_page => params[:per_page] || 10
    end
    @jobs = @search.results

  end

  def buy
    @user = User.find_by(:username => params[:username])
    Purchase.find_or_create_by(:buyer => current_user, :driver => @user)
  end

  def edit_name
  end

  def edit_summary
  end

  def edit_description
  end
  
  def edit_postcode
  end

  def upload_photo
  end

  def crop
  end

  def add_experience_item
    @experience_item = ExperienceItem.new
  end

  def edit_experience_item
    @id = params[:id]
    @experience_item = ExperienceItem.find(@id.to_i)
  end

  def add_qualification_item
    @qualification_item = QualificationItem.new
  end

  def edit_qualification_item
    @id = params[:id]
    @qualification_item = QualificationItem.find(@id.to_i)
  end

  private

  def sort_column
    # if 'no column', it's created_at
    %w[created_at distance].include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    # if 'no attribute': it's going from smallest to biggest, ascending
    # if params[:direction], and params[:direction] == desc, it's decending
    params[:direction] == 'desc' ? 'desc' : 'asc'
  end

end

    # http://blog.websolr.com/post/1336392145/spatial-search-in-sunspot
    # @jobs = @search.results.sort_by { |result| result.distance_to(lat, lng) } if params[:sort] == 'distance'


    # if params[:sort] == 'distance'
    #   if params[:direction] == 'desc'      
    #     @jobs = @jobs.sort {|a,b| a.distance(current_user) <=> b.distance(current_user)}.reverse!
    #   else
    #     @jobs = @jobs.sort {|a,b| a.distance(current_user) <=> b.distance(current_user)}
    #   end
    # else
    #   order_string = sort_direction == "desc" ? sort_column : sort_column+ " desc" # ignor the final desc here, seems like the code is 'doing it wrong'.
    #   @jobs = @jobs.order(order_string)
    # end


