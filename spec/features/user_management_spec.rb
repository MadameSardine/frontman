require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "In order to user chitter I want to sign up" , js: true do 

	scenario "when being logged out" do 
		p Capybara.current_driver
		sign_up("test", "test", "test", "test", "test")
		expect(page).to have_content('@test')
	end

	scenario "with a password that doesn't match" do 
		expect{sign_up('ifu','misifu@me.com', 'misifu' ,'password', 'wrong')}.to change(User, :count).by(0)
		expect(page).to have_content("Passwords don't match")
	end

	scenario "with an email/username that is already registered" do
		sign_up("test", "test", "test", "test", "test")
		sign_up("test", "test", "test", "test", "test")
		expect(page).to have_content("The username or the email is already used")
	end

end

feature "In order to user chitter I want to log in" , js: true do

	before(:each) do
		User.create(:username =>"MadameSardine",
				:email => "sardine@me.com",
				:name => "Sardine Tin",
				:password => "password",
				:password_confirmation => "password")
	end

	scenario "with correct credentials" do
		visit '/'
		expect(page).not_to have_content("@MadameSardine")
		log_in("MadameSardine", "password")
		expect(page).to have_content("@MadameSardine")

	end

	scenario "with incorrect credentials" do
		visit '/'
		expect(page).not_to have_content("@MadameSardine")
		log_in("MadameSardine", "wrong")
		expect(page).not_to have_content("@MadameSardine")

	end
end

feature "In order to get back to work, I want to log out", js: true do

	before(:each) do
		User.create(:username =>"MadameSardine",
				:email => "sardine@me.com",
				:name => "Sardine Tin",
				:password => "password",
				:password_confirmation => "password")
	end

	scenario "while being logged in" do
		log_in("MadameSardine", "password")
		click_link "sign_out_button"
		expect(page).to have_content("Good bye")
		expect(page).not_to have_content("@MadameSardine")
	end
end
