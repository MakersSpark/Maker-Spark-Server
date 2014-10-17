get "/sign_up" do
	@user = User.new 
	erb :sign_up
end

get "/sign_up_with/:rfid_code" do
	erb :sign_up
end

post "/sign_up" do
	@user = User.create(email: 			           params[:email],
		                  github_user:           params[:github_user],
		                  rfid_code:             params[:rfid_code],
						          password:   			     params[:password],	
						          password_confirmation: params[:password_confirmation])

		if @user.save
			session[:user_id] = @user.id
			flash[:notice]    = "Thank you for registering, #{current_user.email}"
			redirect '/'
		else
			flash[:errors] = @user.errors.full_messages
			redirect '/sign_up'
		end


end

get "/sign_in" do
	erb :sign_in
end


post "/sign_in" do
	email, password = params[:email], params[:password]
	user = User.authenticate(email, password)
	if user
		session[:user_id] = user.id
		flash[:notice]  = "Welcome back #{current_user.email}"
		redirect '/'
	else 		
		flash[:errors] = ["This email is not registered", "This password is wrong"]
		redirect "/sign_in"
	end
end

get '/edit_user' do
  @user = User.get(session[:user_id])	

	erb :edit_user
end

post '/edit_user' do
	@user = User.get(session[:user_id])

	@user.update(email: 			         params[:email],
		          github_user:           params[:github_user],
						  password:   			     params[:password],	
						  password_confirmation: params[:password_confirmation])

	if @user.save 

		session[:user_id] = @user.id
		flash[:notice] = "Your details has been successfully updated"
		redirect '/'
	else
		flash[:errors] = @user.errors.full_messages
		redirect '/edit_user' 
	end
end


delete '/' do
	flash[:notice] = "Good bye!"
	session[:user_id] = nil
	redirect '/'
end
