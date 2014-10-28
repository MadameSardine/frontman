post '/peeps/reply' do
	reply = params[:reply]
	Reply.create(:content => reply, :user => current_user, :timestamp => Time.now, :peep_id => params[:peep_id])
	redirect to ('/')
end
