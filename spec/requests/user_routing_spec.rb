require 'spec_helper'

describe "User Routing" do
  let(:user) { FactoryGirl.create(:user, :first_name => "Joe", :admin => false) }
  let(:plan) { FactoryGirl.create(:plan) }


  describe "as a subscribed user" do
    before(:each) do
      FactoryGirl.create(:subscription, user_id: user.id, plan_id: plan.id, status: 'Subscriber')
    end

    describe "user login" do

      it "should login user and route to dashboard" do
        visit new_user_session_path
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
        page.current_path.should == dashboard_path
      end

    end

  end


  describe "as an unsubscribed user" do
    before(:each) do
      FactoryGirl.create(:subscription, user_id: user.id, plan_id: plan.id, status: 'canceled')
    end

    describe "user login" do

      it "should login user and route subscription page" do
        visit new_user_session_path
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
        page.current_path.should == '/plans'
        page.should have_content("Choose a Plan")
      end

    end

  end


end