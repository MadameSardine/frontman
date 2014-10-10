require 'spec_helper' 

feature "User adds a new peep" do 

	before(:each) do
		User.create(:username =>"MadameSardine",
				:email => "sardine@me.com",
				:name => "Sardine Tin",
				:password => "password",
				:password_confirmation => "password")
	end

	scenario "only if logged in" do
		visit '/'
		expect(page).not_to have_content("Post peep")
	end

	scenario "after signing up" do
		expect(Peep.count).to eq(0)
		log_in("MadameSardine", "password")
		expect(page).to have_content("Post peep")
		click_link 'Post peep'
		add_peep("Hello, world")
		expect(Peep.count).to eq(1)
		peep = Peep.first
		expect(peep.content).to eq("Hello, world")
	end

	def add_peep(content)
		within('#new-peep') do
			fill_in "content", :with => content
			click_button 'Post peep'
		end
	end


end