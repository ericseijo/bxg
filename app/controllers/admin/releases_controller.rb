class Admin::ReleasesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin
  before_filter :find_release, except: [:preview, :index ]
  #before_filter :find_client, only: [:edit, :update]
  #before_filter :check_if_this_users_release_or_redirect, except: [:new, :create, :preview]

  def index
    @releases = Release.all
  end

  def show

  end

  def edit

  end

  def update
    @release.client = @client

    if @release.update_attributes(params[:release])
      redirect_to releases_upload_path(@release)
    else
      render action: :edit
    end
  end

  def email_user_release_notes
    @release.status = Release::STATUS[:query_user]
    if @release.save
      ReleaseMailer.send_notes_to_user(@release, params[:notes]).deliver if params[:notes].present?
      redirect_to(admin_releases_path, :notice => "Email sent to customer")
    else
      render action: :show, notice: "There was a problem"
    end
  end

  def preview
    render :layout => false
  end

  def approve_release
    @release.status = Release::STATUS[:approved]

    if @release.save
      ReleaseMailer.notify_user_that_release_is_approved(@release).deliver
      redirect_to(admin_releases_path, :notice => "The release has been approved and the customer has been notified.")
    else
      render action: :show, notice: "There was a problem"
    end

  end


  private

  def find_release
    @release = Release.find(params[:id])
  end

  def find_client
    @client = Client.find(params[:client_id])
  end


end
