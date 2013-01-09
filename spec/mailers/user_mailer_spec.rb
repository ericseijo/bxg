require "spec_helper"

describe UserMailer do
  describe "new_subscription" do
    let(:user) { Factory(:user, :password_reset_token => "anything") }
    let(:user) { FactoryGirl.create(:user, :first_name => "Joe", :last_name => "Subscriber", :email => "joe@example.com") }
    let(:mail) { UserMailer.new_subscriber(user) }

    it "send user password reset url" do
      mail.subject.should eq("Welcome to BaxterGate")
      mail.to.should eq([user.email])
      mail.from.should eq(["noreply@bxg.com"])
      #mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
    end
  end

end
