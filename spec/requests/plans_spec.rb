require 'spec_helper'

describe "Plans" do
  subject { page }
  
  describe "As an admin" do
    let(:admin_user) { FactoryGirl.create(:user, :admin => true) }
    let(:plan) { FactoryGirl.create(:plan, level: "Basic") }

    before(:each) do
      sign_in admin_user
      visit root_path
    end
    
    it { should have_selector('title', text: "BXG Home") }
    
    describe "index" do
      FactoryGirl.create(:plan, level: "Basic")
      FactoryGirl.create(:plan, level: "Plus")
      FactoryGirl.create(:plan, level: "Elite")
      
      before(:each) do
        visit admin_path
      end
      
      it { should have_selector('title'), text: "Admin Dashboard" }
      
      it "should list current plans" do
        click_link('Plans')
        page.should have_selector('h1', text: 'Plans')
        
        Plan.all.each do |plan|
          page.should have_selector('td', text: plan.level)
        end  
      end
      
      it "should have a link to add new plans" do
        visit admin_plans_path
        page.should have_link('Create a New Plan', href: new_admin_plan_path)
        
      end
      
      it "should have a link to show subscription details" do
        visit admin_plans_path
        Plan.all.each do |plan|
          page.should have_link('Details', href: admin_plan_path(plan))
        end
      end
      
    end
    
    describe "show" do
      it "should show subscription details" do
        visit admin_plan_path(plan)
        page.should have_selector('h1', text: "#{plan.level} Details")
        page.should have_content(plan.price)
      end
      
      it "should have a link to edit" do        
        visit admin_plan_path(plan)
        page.should have_link('Edit', href: edit_admin_plan_path(plan))
      end
    end
    
    describe "new" do
      before do
        visit new_admin_plan_path
      end
      
      it "should show have a form which creates a new subscription" do
        visit admin_plans_path
        page.should have_link('Create a New Plan', href: new_admin_plan_path)
        click_link('Create a New Plan')
        page.should have_selector('h1', text: 'New Plan')        
      end
      
      describe "with valid information" do
        
        it "should create a new subscription" do
          fill_in "plan_level", with: "Super Duper"
          fill_in "plan_price", with: "599.99"
          fill_in "plan_number_of_releases_per_month", with: "400"
          fill_in "plan_storage_space", with: "1 TB"
          fill_in "plan_number_of_user_accounts", with: "1000"
          fill_in "plan_description", with: "This is the super duper bestL!"
          check "plan_active"
          expect { click_button "Create Plan" }.to change(Plan, :count).by(1)
          page.should have_selector('p', text: "Plan was successfully created")
        end
        
      end
      
      describe "with invalid information" do
        before do
          before { click_button "Create Plan" }
          it { should have_content('error') }  
        end
      end
      
    end
    
    describe "edit" do
      it "should allow an admin to edit" do
        visit admin_plans_path
        click_link('Edit')
        page.should have_selector('h1', text: 'Edit Plan')
        fill_in "plan_level", with: "Super Super Duper"
        click_button "Update Plan"
        page.should have_selector('p', text: "Plan was successfully updated")
      end
      
      it "should provide a way to deactivate a subscription" do
        visit edit_admin_plan_path(plan)
        page.should have_selector('h1', text: 'Edit Plan')
        uncheck "plan_active"
        click_button "Update Plan"
        page.should have_selector('p', text: "Plan was successfully updated")
        page.should have_content("Active: false")
      end
    end
    
  end
  
  
  describe "As a non admin" do
    let(:user) { FactoryGirl.create(:user, :first_name => "Joe", :admin => false) }
    let(:plan) { FactoryGirl.create(:subscription, level: "Basic") }

    before(:each) do
      sign_in user
    end

    it("should not allow access to admin section") do
      visit admin_plans_path
      page.current_path.should == root_path
    end

    it "should list out the available subscription options" do
      visit plans_path
      page.should have_content("Choose a Plan")
      #save_and_open_page
      page.should have_selector('li', text: "Basic")
      page.should have_selector('li', text: "Plus")
      page.should have_selector('li', text: "Elite")
    end

  end
  
end
