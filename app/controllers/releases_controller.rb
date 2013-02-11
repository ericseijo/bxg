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
      redirect_to releases_upload_path(@release)
    else
      render action: :edit
    end
  end

  def upload
    @release = Release.find(params[:id])
    @assets = @release.assets
    @asset = @assets.first

    if request.post?
      @asset = @release.assets.build(:media => params[:upload][:asset])

      if @asset.save

      end
    end
  end

  def preview
    render :layout => false
  end

  private

  def find_client
    @client = Client.find(params[:client_id])
  end

end
