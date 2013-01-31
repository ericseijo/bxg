require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user, :first_name => "Joe", :last_name => "Subscriber", :admin => false) }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:remember_me) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:company_name) }
  it { should respond_to(:address) }
  it { should respond_to(:address_2) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zip) }
  it { should respond_to(:country) }


  it "should have a full_name" do
    user.full_name.should == "Joe Subscriber"
  end

  describe "as a non subscriber" do
    it "should return false if user is not an active member" do
      user.is_an_active_member?.should be_false
    end

    it "should return false if user is not an active subscriber" do
      user.is_a_valid_subscriber?.should be_false
    end
  end

  describe "as a subscriber" do
    before(:each) do
      @subcription = FactoryGirl.create(:subscription, :user_id => user.id, :status => "Subscriber")
    end

    it "should return true if user is not an active member" do
      user.is_an_active_member?.should be_true
    end

    it "should return true if user is not an active subscriber" do
      user.is_a_valid_subscriber?.should be_true
    end

    it "should show the users's current subscription level" do
      user.subscription_level.strip.should == 'Subscriber'
    end
  end

  describe "subscriptions" do
    it "should have a subscription attribute" do
      user.should respond_to :subscription
    end
  end

  describe "release association" do
    it { should respond_to :releases }
  end

  describe "client association" do
    it { should respond_to :clients }
  end

end
