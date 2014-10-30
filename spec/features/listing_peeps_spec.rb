require 'spec_helper'

feature "User browses the list of peeps" , js: true do 

	before(:each) {
		Peep.create(:content => "Today is a good day",
				:timestamp => "2014-10-10 01:00:00",
				:user => User.create(:username =>"MadameSardine",
					:email => "sardine@me.com",
					:name => "Sardine Tin",
					:password => "password",
					:password_confirmation => "password"))
	}

	scenario "when opening the home page" do
		visit '/'
		log_in("MadameSardine", "password")
		expect(page).to have_content("Today is a good day")
	end

	scenario "and can see who posted the peep" do
		visit '/'
		log_in("MadameSardine", "password")
		expect(page).to have_content("Sardine Tin @MadameSardine")
	end

end