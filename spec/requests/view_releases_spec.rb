require 'spec_helper'

describe "View releases" do
  let(:user) { FactoryGirl.create(:user) }
  let(:release) { FactoryGirl.create(:release, user_id: user.id) }

  subject { :release }

  it "should show a new release" do
    visit view_release_path(release)
    page.should have_content(release.headline)
  end

end