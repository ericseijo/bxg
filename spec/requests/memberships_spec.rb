require 'spec_helper'

describe "Memberships" do
  subject { page }

  describe "for a signed in user" do
    let(:user) { FactoryGirl.create(:user, :first_name => "Joe", :admin => false) }

    before(:each) do
      Plan.delete_all
      FactoryGirl.create(:subscription, level: "Basic")
      FactoryGirl.create(:subscription, level: "Plus")
      FactoryGirl.create(:subscription, level: "Elite")
      sign_in user
    end


  end

  describe "for a non signed in user" do

  end
end
