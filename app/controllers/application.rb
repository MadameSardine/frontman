get '/' do
	@peeps = Peep.all(:order => [ :id.desc])
	@user = User.first(:username => params[:username])
	erb :chitter
end