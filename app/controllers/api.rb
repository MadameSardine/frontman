require 'json'

get '/api/session/:username' do 
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