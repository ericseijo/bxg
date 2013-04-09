require 'spec_helper'

describe Release do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @release = FactoryGirl.create(:release, user_id: user)
  end

  subject { @release }

  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:status) }
  it { should respond_to (:headline) }
  it { should respond_to(:sub_headline) }
  it { should respond_to(:body) }
  it { should respond_to(:link) }
  it { should respond_to(:publish_date) }

  describe "when user_id is not present" do
    before { @release.user_id = nil}
    it { should_not be_valid }
  end

  describe "when a name is not present" do
    before { @release.name = nil }
    it { should_not be_valid }
  end

  describe "when a status is not present" do
    before { @release.status = nil }
    it { should_not be_valid }
  end

  describe "release associations" do
    it { should respond_to(:user) }
    it { should respond_to(:client) }
    it { should respond_to(:distribution_lists)}
  end

end
