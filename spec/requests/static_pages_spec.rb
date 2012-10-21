require 'spec_helper'

describe "Static Pages" do
	describe "Home page" do
		it "should have the content 'BXG'" do
			visit	'/static_pages/home'
			page.should have_content('BXG')
		end		

		it "should have the title 'Home'" do
			visit	'/static_pages/home'
		  page.should have_selector('title', text: "BXG Home")
		end

	end

	describe "About page" do
	  
		it "should have the content 'About' " do
		  visit '/static_pages/about'
		  page.should have_content('About')
		end

		it "should have the title 'About'" do
			visit	'/static_pages/about'
		  page.should have_selector('title', text: "BXG About Us")
		end

	end

end
