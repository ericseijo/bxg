require 'spec_helper'

describe Subscription do
  Plan.delete_all
  let(:user) { FactoryGirl.create(:user) }
  let(:basic) { FactoryGirl.create(:plan, :id => "1", :level => 'Basic') }
  let(:plus) { FactoryGirl.create(:plan, :id => "2", :level => 'Plus') }

  before do
    card = { number: '4242424242424242', exp_month: '11', exp_year: '2013' }
    @subscription = FactoryGirl.create :subscription, user: user, plan: basic, stripe_card_token: card
  end

  subject { @subscription }

  it { should respond_to(:user_id) }
  it { should respond_to(:plan_id) }
  it { should respond_to(:status) }

  it { should be_valid }


  describe "when user_id is not present" do
    before { @subscription.user_id = nil}
    it { should_not be_valid }
  end

  describe "when plan_id is not present" do
    before { @subscription.plan_id = nil}
    it { should_not be_valid }
  end

  describe "when status is not present" do
    before { @subscription.status = nil }
    it { should_not be_valid }
  end

  describe "user association" do
    it { should respond_to :user }
  end

  describe "plan association" do
    it { should respond_to :plan }
  end

  context "mailing to a subscriber" do
    before do
      reset_email
    end

    it "should should email a paid subscriber" do
      @subscription.save_with_payment_for(user)
      last_email.to.should include(user.email)
    end


  end

  context "a paid subscription" do
    before do
      @subscription.save_with_payment_for(user)
      @customer    = Stripe::Customer.retrieve @subscription.stripe_customer_token
      @active_card = @customer.active_card
    end

    its(:status) { should == 'Subscriber' }

    it "should email user subscription info" do
      pending
    end
  end

  context "upgrade a subscription" do
    before do
      @subscription.save_with_payment_for(user)
      @subscription.update_subscription_level_to(plus)
    end

    it "should have a new plan" do
      @customer    = Stripe::Customer.retrieve @subscription.stripe_customer_token
      @customer.should_not be_nil
      @customer.subscription.plan.id.to_i.should == plus.id
      @subscription.plan.should == plus
    end

  end

  context "cancel a subscription" do
    before do
      @subscription.save_with_payment_for(user)
      @subscription.cancel
    end

    it "should be cancelled" do
      @customer = Stripe::Customer.retrieve @subscription.stripe_customer_token
      @customer.should_not be_nil
      @subscription.status.should == "canceled"
    end

  end


end