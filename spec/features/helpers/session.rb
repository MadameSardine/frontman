module SessionHelpers

	def log_in(username, password)
		visit '/'
		expect(page.status_code).to eq(200)
		within ('#sign_in_form') do
			fill_in "username_input", :with => username
			fill_in "password_input", :with => password
			click_button "Sign in"
		end
	end


	def sign_up(username="MadameSardine",
				email="sardine@me.com",
				name="Sardine Tin",
				password="password",
				password_confirmation="password")
		visit '/'
		expect(page.status_code).to eq(200)
		within ('#sign_up_form') do
			fill_in :username, :with => username
			fill_in "new_email", :with => email
			fill_in "new_name", :with => name
			fill_in "new_password", :with => password
			fill_in "new_password_confirmation", :with => password_confirmation
			click_button "Sign up for Chitter"
		end
	end

end