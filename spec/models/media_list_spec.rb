require 'spec_helper'

describe MediaList do

  before do
    @media_list = FactoryGirl.create(:media_list)
  end

  subject { @media_list }

  it { should respond_to(:company) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zip) }
  it { should respond_to(:phone) }
  it { should respond_to(:fax) }
  it { should respond_to(:circulation) }
  it { should respond_to(:url) }
  it { should respond_to(:url) }

  describe "when company is not present" do
    before { @media_list.company = nil }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @media_list.email = nil }
    it { should_not be_valid }
  end

  describe "when email is not formatted correctly" do
    before { @media_list.email = "9ahda.com" }
    it { should_not be_valid }
  end

  describe "finding a match" do
    before do
      MediaList.delete_all
      FactoryGirl.create(:media_list, state: "FL", circulation: 12.5)
      FactoryGirl.create(:media_list, state: "CA", circulation: 10)
      FactoryGirl.create(:media_list, state: "CA", circulation: 20.5)
      FactoryGirl.create(:media_list, state: "WA", circulation: 10.5)
      @distribution_list = FactoryGirl.create(:distribution_list, where: "US", where_area: "CA")
    end

    describe "with a distribution list" do
      it "should return a list of media contacts" do
        media_contacts = MediaList.find_matches_for(@distribution_list)
        media_contacts.should_not be_nil
        media_contacts.size.should == 2
      end

      it "should return a list based on region" do
        pending
      end

      it "should return a list based on country" do
        pending
      end

      it "should return a list based on who, who_sub and what_sub to MediaList" do
        pending
      end

      it "should return search criteria for CA" do
        MediaList.criteria_for(@distribution_list).should == "state = 'CA'"
      end
    end
  end

  describe "adding new list items" do

    describe "with a unique list item" do
      it "should create a new media list" do
       expect { MediaList.add_new_media_contact("Codephreak", "1234 My Street", "Clearwater", "FL", "33755", "727-555-1212", "727-555-1313", 12.2, "http://www.codephreak.com", "info@codephreak.com") }.to change(MediaList, :count).by(1)
      end
    end

    describe "with an existing list item" do
      before do
        MediaList.add_new_media_contact("Codephreak", "1234 My Street", "Clearwater", "FL", "33755", "727-555-1212", "727-555-1313", 12.2, "http://www.codephreak.com", "info@codephreak.com")
      end

      it "should not create a new media list" do
        expect { MediaList.add_new_media_contact("Codephreak", "1234 My Street", "Clearwater", "FL", "33755", "727-555-1212", "727-555-1313", 12.2, "http://www.codephreak.com", "info@codephreak.com") }.to_not change(MediaList, :count).by(1)
      end
    end

  end
end