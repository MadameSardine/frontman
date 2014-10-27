post '/api/sessions/' do 
	@data = JSON.parse(request.body.read)
	@user = User.authenticate(params[:username], params[:password])
	
	if @user
		session[:user_id] = @user.id
	else
		@user = nil
	end
	@user.to_json

end

get '/api/sessions/:username' do 
	@user = User.first(:username => params[:username])
	@user.to_json
end

get '/api/peep' do 
	@peeps = Peep.all
    @peeps.to_json
end

get '/api/reply/:peep_id' do
	@replies = Reply.all(:peep_id => peep.id)
	@replies.to_json
end

delete '/api/sessions/' do
	session[:user_id] = nil
end