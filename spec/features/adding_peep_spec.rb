require 'spec_helper' 
require_relative 'helpers/session'

include SessionHelpers

feature "User adds a new peep" , js: true  do 

	scenario "only if logged in" do
		visit '/'
		expect(page).not_to have_content("Send")
	end

	scenario "after signing up" do
		sign_up("test", "test", "test", "test", "test")
		expect(page).to have_content("Send")
	end

	def add_peep(content)
		within('#peep_box') do
			fill_in "content", :with => content
			click_link "validate_peep"
		end
	end


end