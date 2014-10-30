post '/api/sessions/' do 
	@data = JSON.parse(request.body.read)
	@user = User.authenticate(@data["username"], @data["password"])
	session[:user_id] = @user.id if @user
	@user.to_json
end

post '/api/peeps/' do 
	@data = JSON.parse(request.body.read)
	@user = User.first(:username => @data["username"])
	Peep.create(:content => @data["content"], :user => @user, :timestamp => Time.now)
end

post '/api/users/' do 
	@data = JSON.parse(request.body.read)
	@user = User.new(:username => @data["username"],
				:email => @data["email"],
				:name => @data["name"],
				:password => @data["password"],
				:password_confirmation => 
				@data["password_confirmation"])
	if @user.save
		session[:user_id] = @user.id	
	else	
		@user = nil
	end
	@user.to_json
	
end

get '/api/userpeeps/:profile_name' do 
	@user = User.first(:username => @params[:profile_name])
	@user_id = @user.id
	@peeps = Peep.all(:user_id => @user_id, :order => [ :id.desc])
	@info = [@user, @peeps]
	@info.to_json
end

