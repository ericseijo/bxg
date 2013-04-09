class ReleaseMailer < ActionMailer::Base
  default from: "noreply@bxg.com"

  def release_preview(release, user_from, email_to)
    @release = release
    @user_from = user_from
    mail :to => email_to, :subject => "BXG Press Release Preview"
  end

  # email to media contact
  def deliver_release(release, user_from, email_to)
    @release = release
    @user_from = user_from
    mail :to => email_to, :subject => "BXG Press Release"
  end

end
