require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "In order to user chitter I want to sign up" do 

	scenario "when being logged out" do 
		expect {sign_up}.to change(User, :count).by(1)
		expect(page).to have_content('Welcome, MadameSardine')
		expect(User.first.username).to eq("MadameSardine")
		expect(User.first.email).to eq("sardine@me.com")
		expect(User.first.name).to eq("Sardine Tin")
	end

	scenario "with a password that doesn't match" do 
		expect{sign_up('ifu','misifu@me.com', 'misifu' ,'password', 'wrong')}.to change(User, :count).by(0)
		expect(current_path).to eq('/users')
		expect(page).to have_content("Password does not match the confirmation")
	end

	scenario "with an email that is already registered" do
		expect{sign_up}.to change(User, :count).by(1)
		expect{sign_up("test", "sardine@me.com", "test", "test")}.to change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end

	scenario "with an username that is already registered" do
		expect{sign_up}.to change(User, :count).by(1)
		expect{sign_up("MadameSardine", "test@me.com", "test", "test")}.to change(User, :count).by(0)
		expect(page).to have_content("This username is already taken")
	end

end

feature "In order to user chitter I want to log in" do

	before(:each) do
		User.create(:username =>"MadameSardine",
				:email => "sardine@me.com",
				:name => "Sardine Tin",
				:password => "password",
				:password_confirmation => "password")
	end

	scenario "with correct credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, MadameSardine")
		log_in("MadameSardine", "password")
		expect(page).to have_content("Welcome, MadameSardine")

	end

	scenario "with incorrect credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, MadameSardine")
		log_in("MadameSardine", "wrong")
		expect(page).not_to have_content("Welcome, MadameSardine")

	end
end

feature "In order to get back to work, I want to log out" do

	before(:each) do
		User.create(:username =>"MadameSardine",
				:email => "sardine@me.com",
				:name => "Sardine Tin",
				:password => "password",
				:password_confirmation => "password")
	end

	scenario "while being logged in" do
		log_in("MadameSardine", "password")
		click_button "Log out"
		expect(page).to have_content("Good bye!")
		expect(page).not_to have_content("Wecome, MadameSardine")
	end
end
