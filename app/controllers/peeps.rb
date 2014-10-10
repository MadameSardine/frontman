get '/peeps/new' do
	erb :"peeps/new"
end

post '/peeps' do
	content = params[:content]
	Peep.create(:content => content, :user => current_user, :timestamp => Time.now)
	redirect to ('/')
end
