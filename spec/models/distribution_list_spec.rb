require 'spec_helper'

describe DistributionList do
  let(:release) { FactoryGirl.create(:release) }

  before do
    @distribution_list = FactoryGirl.create(:distribution_list, release_id: release)
  end

  subject { @distribution_list }

  it { should respond_to(:release_id) }
  it { should respond_to(:name) }
  it { should respond_to(:where) }
  it { should respond_to(:where_area) }
  it { should respond_to(:who) }
  it { should respond_to(:who_sub) }
  it { should respond_to(:what) }
  it { should respond_to(:what_sub) }

  describe "when release_id is not present" do
    before { @distribution_list.release_id = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @distribution_list.name = nil }
    it { should_not be_valid }
  end

end
