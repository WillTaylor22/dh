class Users::SessionsController < Devise::SessionsController
  clear_respond_to
  respond_to :json, :html
  before_action :redirect_if_not_signed_in

  private

  def redirect_if_not_signed_in
    if !user_signed_in?
      flash[:notice] = "Could not sign in."
      redirect_to root_path
    end
  end

end
