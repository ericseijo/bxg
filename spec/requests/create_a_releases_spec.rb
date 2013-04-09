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

  it "should not allow a user to view another users releases" do

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

  describe "preview" do
    it "should allow a creator to preview" do

    end

    it "should not allow a non creator to preview" do

    end

    it "should allow creator to copy link for external preview" do

    end

    it "should allow creator to email a copy of the preview release" do

    end
  end

  describe "publish" do
    let(:client) { FactoryGirl.create(:client) }
    let(:release) { FactoryGirl.create(:release, client_id: client.id, user_id: user.id) }

    before(:each) do
      #visit "releases/#{release.id}/schedule_release"
      visit schedule_release_path(release)
    end

    it "should schedule a release for publish" do
      page.should have_content("When do you want to publish?")
      page.should have_content("Terms of service.")
      fill_in 'publish_date', with: '05/01/2013 02:30pm'
      check 'terms_of_service'
      click_button "Submit for review"
      #save_and_open_page
      page.should have_content('Congratulations!')
    end
  end



end
