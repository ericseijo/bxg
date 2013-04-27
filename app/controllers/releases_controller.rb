class ReleasesController < ApplicationController
  before_filter :authenticate_user!, except: [:pickup_release, :public_view]
  before_filter :find_release, except: [:new, :create, :preview ]
  before_filter :find_client, only: [:edit, :update]
  before_filter :check_if_this_users_release_or_redirect, except: [:new, :create, :preview, :pickup_release]

  def show
    @pickups = @release.release_pickups(:include => :media_lists)
  end

  def new
    @release = Release.new
  end

  def edit

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
    @release.client = @client

    if @release.update_attributes(params[:release])
      redirect_to releases_upload_path(@release)
    else
      render action: :edit
    end
  end

  def upload
    @assets = @release.assets
    @asset = @assets.first

    if request.post?
      @asset = @release.assets.build(:media => params[:upload][:asset])

      if @asset.save

      end
    end
  end

  def email_release
    # @TODO - Fix email release form not passing ID...
    ReleaseMailer.release_preview(@release, current_user, params[:email]).deliver if params[:email].present?
    redirect_to(release_path(@release), :notice => "Email sent to #{params[:email]}")
  end

  def preview
    render :layout => false
  end

  def schedule_release

    if request.post?
      if params[:terms_of_service].present? && params[:publish_date].present?
        @release.publish_date = params[:formatted_date_time]
        @release.status = Release::STATUS[:submitted]
        if @release.save
          redirect_to(release_path(@release), :notice => "Congratulations! Your release has een submitted for review.")
        else
          render action: :schedule_release, notice: "There was a problem"
        end

      end


    end
    
  end

  def public_view
    @release = Release.find(params[:id])
  end

  def pickup_release
    @media_contact = MediaList.find(params[:media_list_id])
    if @media_contact
      @release.picked_up_by(@media_contact)
      redirect_to(press_release_path(@release))
    else
      redirect_to(root_path)
    end
  end

  private

  def find_release
    @release = Release.find(params[:id])
  end

  def find_client
    @client = Client.find(params[:client_id])
  end

  def check_if_this_users_release_or_redirect
    redirect_to dashboard_path if @release.user != current_user
  end

end
