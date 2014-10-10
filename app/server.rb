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

get '/' do
	erb :index
end

get '/users/new' do

	erb :"users/new"
end

post '/users' do 
	user = User.create(:username => params[:username],
				:email => params[:email],
				:name => params[:name],
				:password => params[:password],
				:password_confirmation => params[:password_confirmation])
	session[:user_id] = user.id
	redirect to '/'
end
