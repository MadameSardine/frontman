get '/' do
	@peeps = Peep.all(:order => [ :timestamp.desc])
	@user = User.first(:username => params[:username])
	erb :chitter
end