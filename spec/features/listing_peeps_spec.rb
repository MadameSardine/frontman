require 'spec_helper'

feature "User browses the list of peeps" do 

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
		expect(page).to have_content("Today is a good day")
		expect(page).to have_content("Submitted on 2014-10-10T01:00:00+01:00")
	end

	scenario "and can see who posted the peep" do
		visit '/'
		expect(page).to have_content("Posted by MadameSardine (Sardine Tin)")
	end

end