class ReleasesController < ApplicationController
  before_filter :find_client, only: [:edit, :update]

  def new
    @release = Release.new
  end

  def edit
    @release = Release.find(params[:id])
  end

  def create
    @release = current_user.releases.new(params[:release])
    @release.status = Release::STATUS[:pending]

    if @release.save
      redirect_to(new_release_client_path(@release), :notice => "Release created")
    else
      render(:action => :new)
    end
  end

  def update
    @release = Release.find(params[:id])

    if @release.update_attributes(params[:release])
      #redirect_to controller: :releases, action: :upload, id: @release
      redirect_to releases_upload_path(@release)
    else
      render action: :edit
    end
  end

  def upload

  end

  private

  def find_client
    @client = Client.find(params[:client_id])
  end

end
