class ClientsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_for_release

  def index
    
  end

  def new
    @client = Client.new
    @client.build_logo
  end

  def create
    @client = current_user.clients.new(params[:client])

    if @client.save
      create_asset if there_is_a_logo?
      redirect_to edit_client_release_path(@client, @release)
    else
      render 'new'
    end
  end

  private

  def check_for_release
    @release = Release.find(params[:release_id])
    redirect_to dashboard_path unless @release.present?
  end

  def there_is_a_logo?
    params[:logo_file].present?
  end

  def create_asset
    asset = @client.build_logo
    asset.media = params[:logo_file][:logo]
    asset.save
  end

end
