class DistributionListsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_release

  def show
    @distribution_list = @release.distribution_lists.find(params[:id])
    @media_contacts = MediaList.find_matches_for(@distribution_list)
  end

  def new
    @distribution_list = DistributionList.new
  end

  def create
    @distribution_list = @release.distribution_lists.new(params[:distribution_list])

    if @distribution_list.save
      redirect_to release_distribution_list_path(@release, @distribution_list)
    else
      render :new
    end
  end

  def edit
    @distribution_list = DistributionList.find(params[:id])
  end

  def update
    @distribution_list = DistributionList.find(params[:id])

    if @distribution_list.update_attributes(params[:distribution_list])
      redirect_to release_distribution_list_path(@release, @distribution_list)
    else
      render :edit
    end
  end

  private

  def  find_release
    @release = Release.find(params[:release_id])
  end


end
