class PagesController < ApplicationController

  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def projects
  end

  def profile
    @user = User.find_by(:username => params[:username])
    @experience_items = @user.experience_items.where(current: true).order(start_date: :desc)
    @experience_items += @user.experience_items.where(current: false).order(end_date: :desc)
    @qualification_items = @user.qualification_items.where(current: true).order(start_date: :desc)
    @qualification_items += @user.qualification_items.where(current: false).order(end_date: :desc)
  end

  def chat
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
    if params[:search]
      @search = Job.search do
        keywords params[:search]   
        # with(:created_at).less_than(params[:time]) if params[:time]
        paginate :page => params[:page], :per_page => params[:per_page] || 10
      end
      @jobs = @search.results
    else
      if params[:sort] == 'distance'
        if params[:direction] == 'desc'      
          @jobs = Job.all.sort {|a,b| a.distance(current_user) <=> b.distance(current_user)}.reverse!
        else
          @jobs = Job.all.sort {|a,b| a.distance(current_user) <=> b.distance(current_user)}
        end
      else
        order_string = sort_direction == "desc" ? sort_column : sort_column+ " desc" # ignor the final desc here, seems like the code is 'doing it wrong'.
        @jobs = Job.order(order_string)
      end
    end
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
