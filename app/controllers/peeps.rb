get '/peeps/new' do
	erb :"peeps/new"
end

post '/peeps' do
	content = params[:content]
	Peep.create(:content => content, :user => current_user, :timestamp => Time.now)
	redirect to ('/')
end

post '/peeps/reply' do
	reply = params[:reply]
	Reply.create(:content => reply, :user => current_user, :timestamp => Time.now, :peep_id => params[:peep_id])
	redirect to ('/')
end
