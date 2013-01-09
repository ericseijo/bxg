require 'spec_helper'

describe Plan do
  
  before { @subscription = Plan.new(level: "Basic", price: 299.99, number_of_releases_per_month: 5, storage_space: "20 GB", number_of_user_accounts: 10, description: "Awesome", active: true) }
  subject { @subscription }
  
  it { should respond_to(:active) }
  it { should respond_to(:description) }
  it { should respond_to(:level) }
  it { should respond_to(:number_of_releases_per_month) }
  it { should respond_to(:number_of_user_accounts) }
  it { should respond_to(:price) }
  it { should respond_to(:storage_space) }
  
  it { should be_valid }


  describe "when description is not present" do
    before { @subscription.description = nil}
    it { should_not be_valid }
  end

  describe "when level is not present" do
    before { @subscription.level = nil }
    it { should_not be_valid }
  end

  describe "when number_of_releases is not present" do
    before { @subscription.number_of_releases_per_month = nil }
    it { should_not be_valid }
  end

  describe "when number_of_user_accounts is not present" do
    before { @subscription.number_of_user_accounts = nil }
    it { should_not be_valid }
  end

  describe "when price is not present" do
    before { @subscription.price = nil }
    it { should_not be_valid }
  end

  describe "when storage_space is not present" do
    before { @subscription.storage_space = nil }
    it { should_not be_valid }
  end

  describe "when when price is not a number" do
    before { @subscription.price = "cheap"}
    it { should_not be_valid }
  end

  describe "when when number_of_releases is not a number" do
    before { @subscription.number_of_releases_per_month = "twentytwo"}
    it { should_not be_valid }
  end

  describe "when when number_of_user_accounts is not a number" do
    before { @subscription.number_of_user_accounts = "twentytwo"}
    it { should_not be_valid }
  end

  describe "with active attribute set to inactive" do
    before do
      @subscription.save!
      @subscription.toggle!(:active)
    end

    it { should_not be_active }
  end

  describe "subscription association" do
    it { should respond_to :subscriptions }
  end

  describe "returning active" do
    before (:each) do
      Plan.delete_all
      FactoryGirl.create(:plan, active: true)
      FactoryGirl.create(:plan, active: true)
      FactoryGirl.create(:plan, active: false)
    end

    it "should return only active Plans" do
      Plan.all_active.size.should == 2
    end
  end
end
