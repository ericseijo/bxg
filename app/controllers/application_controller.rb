class ApplicationController < ActionController::Base
  protect_from_forgery


  def after_sign_in_path_for(current_user)
    if current_user.is_an_active_member?
      dashboard_path
    else
      plans_path
    end

  end

  private

  def authenticate_admin
    if !current_user.admin?
      redirect_to root_url, notice: "Page doesn't exist"
    end
  end

end
