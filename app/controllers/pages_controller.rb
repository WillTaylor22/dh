class PagesController < ApplicationController

  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def my_jobs
  end

  def onboarding
  end

  def profile
    @user = User.find_by(:username => params[:username])
    @user.has_been_viewed_by(current_user) # save the profileview
    @experience_items = @user.ordered_experience_items
    @qualification_items = @user.ordered_qualification_items
  end

  def chat
    @viewed = current_user.viewed
    @conversed_with = current_user.conversed_with
    @purchased = current_user.drivers
  end

  # def drivers
  #   @drivers = User.all
  #   # @search = User.search do
  #   #   fulltext params[:search]
  #   # end
  #   # @drivers = @search.results
  # end

  def job
    @job = Job.find(params[:id])
  end

  def jobs
    @category = retrieve_category_from_params
    @jobs = Job.filter_by_params(params, current_user)
  end

  def buy
    @user = User.find_by(:username => params[:username])
    Purchase.find_or_create_by(:buyer => current_user, :driver => @user)
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

  def retrieve_category_from_params
    Category.find_by(vehicle: params[:category].titleize) if params[:category]
  end

end

    # http://blog.websolr.com/post/1336392145/spatial-search-in-sunspot
    # @jobs = @search.results.sort_by { |result| result.distance_to(lat, lng) } if params[:sort] == 'distance'



