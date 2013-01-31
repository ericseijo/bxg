require 'spec_helper'

describe Client do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @client = FactoryGirl.create(:client, user_id: user)
  end

  subject { @client }

  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:ticker_symbol) }
  it { should respond_to(:website) }

  describe "when user_id is not present" do
    before { @client.user_id = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @client.name = nil }
    it { should_not be_valid }
  end

  describe "user association" do
    it { should respond_to :user }
  end
end