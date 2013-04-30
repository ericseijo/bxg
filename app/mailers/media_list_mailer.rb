class MediaListMailer < ActionMailer::Base
  default from: "noreply@bxg.com"

  def message_contact(media_contact, release, message, user_from=nil)
    @release = release
    @user_from = user_from
    @media_contact = media_contact
    @message = message

    mail :to => media_contact.email, :subject => "BXG Press Release Message"
  end

  def notify_user_of_message_reply(media_contact, release, message)
    @release = release
    @user_from = media_contact
    @media_contact = media_contact
    @message = message

    mail :to => @user_from.email, :subject => "BXG Press Release Message"
  end

end
