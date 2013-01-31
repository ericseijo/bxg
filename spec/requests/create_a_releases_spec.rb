require 'spec_helper'

describe "Create a Release" do
  let(:user) { FactoryGirl.create(:user, :first_name => "Joe", :admin => false) }
  let(:plan) { FactoryGirl.create(:plan) }
  let(:subscription) { FactoryGirl.create(:subscription, user_id: user.id, plan_id: plan.id, status: 'Active') }

  before(:each) do
    sign_in user
    visit dashboard_path
  end

  it "should only allow logged in user's access" do
    
  end
  
  it "should not allow a valid user to create a release" do

  end

  it "should only allow logged in user's access clients" do

  end

  it "should not allow a valid user to create a client" do

  end

  it "should should not allow be allowed to be edited without a client" do

  end

  it "lets a valid user create a new release" do
    click_link "New release"
    fill_in "release_name", with: "My First Release"
    click_button "Create"
    page.should have_content("Add a new client")
    fill_in "client_name", with: "Client 1"
    fill_in "client_ticker_symbol", with: "CLI123"
    fill_in "client_website", with: "http://example.com"
    click_button "Add client"
    page.should have_content("Write your release")
    page.should have_content(user.full_name)
    page.should have_content(user.email)
    fill_in 'release_headline', with: "Headline"
    fill_in 'release_sub_headline', with: 'Sub Headline'
    fill_in 'release_link', with: 'http://example.com'
    select_date Date.tomorrow, :from => 'release_publish_date'
    click_button "Save"
    page.should have_content("Upload files")

    #TODO NEXT - Add asset uploading
  end



end
