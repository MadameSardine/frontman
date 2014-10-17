require 'spec_helper'

feature "User wants to reply to peeps" do 

	before(:each) {
		Peep.create(:content => "Today is a good day",
				:timestamp => "2014-10-10 01:00:00",
				:user => User.create(:username =>"Ana",
					:email => "ana@test.com",
					:name => "Ana",
					:password => "test",
					:password_confirmation => "test"))
	}

	before(:each) {
		User.create(:username =>"MadameSardine",
				:email => "sardine@me.com",
				:name => "Sardine Tin",
				:password => "password",
				:password_confirmation => "password")
	}

	scenario "when logged in I should be able to reply" do 
		log_in("MadameSardine", "password")
		expect(page).to have_content("reply")
	end

	





end