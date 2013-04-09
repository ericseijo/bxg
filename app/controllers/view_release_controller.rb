class ViewReleaseController < ApplicationController

  def show
    @release = Release.find(params[:id])
  end
end
