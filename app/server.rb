require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'

require_relative 'helpers/application'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './app/models/user.rb'
require './app/models/peep.rb'


DataMapper.finalize

DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
	@peeps = Peep.all
	erb :index
end

get '/users/new' do
	@user = User.new
	erb :"users/new"
end

post '/users' do 
	@user = User.new(:username => params[:username],
				:email => params[:email],
				:name => params[:name],
				:password => params[:password],
				:password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to '/'
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end

get '/sessions/new' do
	erb :"sessions/new"
end

post '/sessions' do
	username, password = params[:username], params[:password]
	user = User.authenticate(username, password)
	if user
		session[:user_id] = user.id
		redirect to ('/')
	else
		flash[:errors] = ["The username or password is incorrect"]
		erb :"sessions/new"
	end
end

delete '/sessions' do
	flash[:notice] = "Good bye!"
	session[:user_id] = nil
	redirect to ('/')
end

get '/peeps/new' do
	erb :"peeps/new"
end

post '/peeps' do
	content = params[:content]
	Peep.create(:content => content)
	redirect to ('/')
end





