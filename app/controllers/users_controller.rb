require_relative "../server.rb"

class UsersController < SparkPrint

	before do 
		@user = current_user 
	end

	get "/" do 
		redirect '/users/sign_up'
	end

	get "/sign_up" do
		@user = User.new 
		erb :sign_up
	end

	get "/sign_up_with/:rfid_code" do
		erb :sign_up
	end

	post "/sign_up" do
		@user = User.create(params)

		if @user.save
			session[:user_id] = @user.id
			flash[:notice]    = "Thank you for registering, #{current_user.email}"
			redirect '/'
		else
			flash[:errors] = @user.errors.full_messages
			redirect '/users/sign_up'
		end
	end

	get "/sign_in" do
		erb :sign_in
	end

	post "/sign_in" do
		@user = sign_in(params[:email], params[:password]) 	
		if @user
			redirect '/'  		
		else
			redirect "/users/sign_in"
		end
	end

	get '/edit_user' do 
		erb :edit_user
	end

	post '/edit_user' do
		@user.update(params)
		if @user.save 
			session[:user_id] = @user.id
			flash[:notice] = "Your details have been successfully updated"
			redirect '/'
		else
			flash[:errors] = @user.errors.full_messages
			redirect '/users/edit_user' 
		end
	end

	delete '/' do
		flash[:notice] = "Good bye!"
		session[:user_id] = nil
		redirect '/'
	end

	helpers do 
		def sign_in(email,password)
			user = User.authenticate(email,password)
			if user 
				session[:user_id] = user.id
				flash[:notice]  = "Welcome back #{current_user.email}"
			else
				flash[:errors] = ["We couldn't find that email address – make sure it's typed correctly.", "There's something wrong with your password."]
			end
			user
		end
		
		def current_user
			User.get(session[:user_id])	
		end

	end

end





