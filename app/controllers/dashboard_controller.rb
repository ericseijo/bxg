class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @releases = Release.find_all_by_user_id(current_user)
  end
end
