require 'json'

post '/api/sessions/' do 
	@data = JSON.parse(request.body.read)
	@user = User.authenticate(params[:username], params[:password])
	session[:user_id] = @user.id if (@user)
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