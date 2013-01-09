class UserMailer < ActionMailer::Base
  default from: "noreply@bxg.com"

  def new_subscriber(user)
    @user = user
    mail :to => user.email, :subject => "Welcome to BaxterGate"
  end

end
