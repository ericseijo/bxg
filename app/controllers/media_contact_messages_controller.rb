class MediaContactMessagesController < ApplicationController
  before_filter :find_release, :find_media_contact, except: [:show, :message_sent]

  def show
    @media_contact_message = MediaContactMessage.find(params[:id])
  end

  def new
    @media_contact_message = MediaContactMessage.new
  end

  def create
    @media_contact_message = MediaContactMessage.new(params[:media_contact_message])
    @media_contact_message.release_id = @release.id
    @media_contact_message.media_list_id = @media_contact.id
    set_origination_point

    if @media_contact_message.save
      if @media_contact_message.originator == MediaContactMessage::ORIGIN[:user]
        MediaListMailer.message_contact(@media_contact, @release, @media_contact_message, current_user).deliver
        redirect_to release_path(@release), :notice => "Your message was sent."
      else
        MediaListMailer.notify_user_of_message_reply(@media_contact, @release, @media_contact_message).deliver
        redirect_to :controller => :media_contact_messages, :action => :message_sent, :notice => "Your message was sent."
      end
      
    else
      render :new
    end

  end

  def message_sent
    
  end

  private

  def find_release
    @release = Release.find(params[:release_id])
  end

  def find_media_contact
    @media_contact = MediaList.find(params[:media_list_id])
  end

  def set_origination_point
    if current_user.present?
      @media_contact_message.originator = MediaContactMessage::ORIGIN[:user]
    else
      @media_contact_message.originator = MediaContactMessage::ORIGIN[:media_contact]
    end
  end

end
