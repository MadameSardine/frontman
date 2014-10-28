# post '/users' do 
# 	@user = User.new(:username => params[:username],
# 				:email => params[:email],
# 				:name => params[:name],
# 				:password => params[:password],
# 				:password_confirmation => params[:password_confirmation])
# 	if @user.save
# 		session[:user_id] = @user.id
		
# 	else
# 		flash.now[:errors] = @user.errors.full_messages
# 	end
# 	redirect '/'
# end