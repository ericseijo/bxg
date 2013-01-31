class ClientsController < ApplicationController

  before_filter :check_for_release

  def index
    
  end

  def new
    @client = Client.new
  end

  def create
    @client = current_user.clients.new(params[:client])


    if @client.save
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

end
