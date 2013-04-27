class ReleaseMailer < ActionMailer::Base
  default from: "noreply@bxg.com"

  def release_preview(release, user_from, email_to)
    @release = release
    @user_from = user_from
    mail :to => email_to, :subject => "BXG Press Release Preview"
  end

  # email to media contact
  def deliver_release(release, user_from, media_contact)
    @release = release
    @user_from = user_from
    @media_contact = media_contact
    mail :to => @media_contact.email, :subject => "BXG Press Release"
  end

  def send_notes_to_user(release, notes)
    @release = release
    @user_to = release.user
    @notes = notes
    mail :to => @user_to.email, :subject => "Questions Regarding Your BXG Press Release"
  end

  def notify_user_that_release_is_approved(release)
    @release = release
    @user_to = release.user
    mail :to => @user_to.email, :subject => "Your BXG Press Release Has Been Approved"
  end
end
