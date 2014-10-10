require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'

require_relative 'helpers/application'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './app/models/user.rb'


DataMapper.finalize

DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
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
		flash[:notice] = "Sorry, your passwords don't match"
		erb :"users/new"
	end
end
