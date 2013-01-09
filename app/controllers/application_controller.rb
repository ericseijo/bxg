class ApplicationController < ActionController::Base
  protect_from_forgery


  def after_sign_in_path_for(resource)
    if current_user.is_an_active_member?
      #user_console_path(current_user)
      dashboard_path
    else
      #new_user_plan_path(current_user)
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
