require 'spec_helper'

describe "User Signup" do
  before(:each) do
    Plan.delete_all
    FactoryGirl.create(:plan, level: "Basic", :id => "1")
    FactoryGirl.create(:plan, level: "Plus", :id => "2")
    FactoryGirl.create(:plan, level: "Elite", :id => "3")
  end

  it "should redirect a logged in user with no active plans to the subscription selection page" do
    #let(:user) { FactoryGirl.create(:user, :first_name => "Joe", :admin => false) }

  end

  it "should route a new user through the subscription process" do
    visit root_path
    click_link "Sign up"
    page.current_path.should == new_user_registration_path
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Company name", with: "Acme"
    fill_in "Email", with: "johndoe@gmail.com"
    fill_in "Password", with: "p@ssword!"
    fill_in "Password confirmation", with: "p@ssword!"
    click_button "Sign up"
    page.should have_content("Choose a Plan")
    choose "plan_id_1"
    click_button "Continue"
    page.should have_content("Basic Membership")
    page.should have_content("Enter Payment Information")
    fill_in "Credit Card", with: "4444444444444444"
    fill_in "card_code", with: "583"
    select "7", from: "card_month"
    select "2016", from: "card_year"
    fill_in "user_address", with: "555 My St"
    fill_in "user_city", with: "Clearwater"
    fill_in "user_state", with: "FL"
    fill_in "user_zip", with: "33756"
    # Need to figure out
    #click_button "Subscribe"
    #page.should have_content("Thanks for signing up!")
    #page.current_path.should == dashboard_path
  end

  it "should allow a new user to try the service without entering credit card info" do
    visit root_path
    click_link "Sign up"
    page.current_path.should == new_user_registration_path
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Company name", with: "Acme"
    fill_in "Email", with: "johndoe@gmail.com"
    fill_in "Password", with: "p@ssword!"
    fill_in "Password confirmation", with: "p@ssword!"
    click_button "Sign up"
    page.should have_content("Choose a Plan")
    choose "plan_id_1"
    click_button "I just want to try it out"
    page.current_path.should == dashboard_path
    page.should have_content("User Dashboard")
    page.should have_content("trial")
    last_email.to.should include("johndoe@gmail.com")
  end

  it "should not create a new subscription for a user who already has one" do
    pending
  end

end