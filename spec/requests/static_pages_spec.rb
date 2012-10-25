require 'spec_helper'

describe "Static Pages" do
	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_content('BXG') }

		it { should have_selector('title', text: "BXG Home") }

	end

	describe "About page" do
	  before { visit about_path }

		it { should have_content('About') }

		it { should have_selector('title', text: "BXG About Us") }

	end

	describe "Contact page" do
		before { visit contact_path }

    it { should have_selector('h1', text: 'Contact') }

    it { should have_selector('title', text: "Contact") } 

  end

end
