require 'spec_helper'

describe "Distribution Lists" do
  let(:user) { FactoryGirl.create(:user, :first_name => "Joe", :admin => false) }
  let(:plan) { FactoryGirl.create(:plan) }
  let(:subscription) { FactoryGirl.create(:subscription, user_id: user.id, plan_id: plan.id, status: 'Active') }
  let(:client) { FactoryGirl.create(:client) }
  let(:release) { FactoryGirl.create(:release, client_id: client.id) }
  let(:list) { FactoryGirl.create(:distribution_list, release_id: release.id)}


  before(:each) do
    sign_in user
  end

  describe "create a new distribution list" do
    before(:each) do
      FactoryGirl.create(:media_list, state: "FL", circulation: 12.5)
      FactoryGirl.create(:media_list, state: "CA", circulation: 10)
      FactoryGirl.create(:media_list, state: "CA", circulation: 20.5)
      FactoryGirl.create(:media_list, state: "WA", circulation: 10.5)
      visit new_release_distribution_list_path(release)
    end

    it "should create a new distribution list with media contacts only in CA" do
      fill_in "distribution_list_name", with: "USA Main"
      select "USA", from: "distribution_list_where"
      select "California", from: "distribution_list_where_area"
      select "All", from: "distribution_list_who"
      select "All", from: "distribution_list_who_sub"
      select "Business", from: "distribution_list_what"
      select "Markets", from: "distribution_list_what_sub"
      click_button "Build this list"
      page.should have_content("Your list generated 2 Contacts with 30,500 Subscribers")
      page.should have_link('Preview Release', href: release_path(release))
    end

    it "should create a new distribution list with all media contacts in US" do
      fill_in "distribution_list_name", with: "USA Main"
      select "USA", from: "distribution_list_where"
      select "All States", from: "distribution_list_where_area"
      select "All", from: "distribution_list_who"
      select "All", from: "distribution_list_who_sub"
      select "Business", from: "distribution_list_what"
      select "Markets", from: "distribution_list_what_sub"
      click_button "Build this list"
      page.should have_content("Your list generated 4 Contacts with 53,500 Subscribers")
      page.should have_link('Preview Release', href: release_path(release))
    end

  end


  describe "edit a distribution list" do

    before(:each) do
      visit edit_release_distribution_list_path(release, list)
    end

    it "should create a new distribution list" do
      fill_in "distribution_list_name", with: "USA Updated"
      select "USA", from: "distribution_list_where"
      select "Florida", from: "distribution_list_where_area"
      select "All", from: "distribution_list_who"
      select "All", from: "distribution_list_who_sub"
      select "Business", from: "distribution_list_what"
      select "Markets", from: "distribution_list_what_sub"
      click_button "Save this list"
      page.should have_content("Your list generated")
    end

  end



end