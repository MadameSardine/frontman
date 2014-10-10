require 'spec_helper'

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
		expect{sign_up}.to change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end

	def sign_up(username="MadameSardine",
				email="sardine@me.com",
				name="Sardine Tin",
				password="password",
				password_confirmation="password")
		visit '/users/new'
		expect(page.status_code).to eq(200)
		fill_in :username, :with => username
		fill_in :email, :with => email
		fill_in :name, :with => name
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Sign up"
	end

end

