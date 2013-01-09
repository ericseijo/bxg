class PlansController < ApplicationController
  before_filter :authenticate_user!

  def index
    @plans = Plan.all_active
  end

  def show
    @subscription = Plan.find(params[:id])
  end
end
