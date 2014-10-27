get '/' do
	@peeps = Peep.all(:order => [ :timestamp.desc])
	erb :chitter
end