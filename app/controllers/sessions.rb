# get '/sessions/new' do
# 	erb :"sessions/new"
# end

# post '/sessions' do
# 	username, password = params[:username], params[:password]
# 	user = User.authenticate(username, password)
# 	if user
# 		session[:user_id] = user.id

# 	else
# 		flash[:errors] = ["The username and password you entered did not match our records. Please double-check and try again."]
# 	end

# end

# delete '/sessions' do
# 	flash[:notice] = "Good bye!"
# 	session[:user_id] = nil
# 	redirect to ('/')
# end