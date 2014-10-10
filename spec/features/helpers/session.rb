module SessionHelpers

	def log_in(username, password)
			visit '/sessions/new'
			expect(page.status_code).to eq(200)
			fill_in :username, :with => username
			fill_in :password, :with => password
			click_button "Log in"
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