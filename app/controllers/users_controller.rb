require_relative "../server.rb"

class UsersController < SparkPrint

	before do 
		@user = current_user 
	end

	get "/" do 
		redirect '/'
	end

	get "/sign_up" do
		@user = User.new 
		erb :sign_up
	end

	get "/sign_up_with/:rfid_code" do
		if @user
			flash[:notice] = "You're already a registered user!"
			redirect '/'
		end
		erb :sign_up
	end

	post "/sign_up" do
		@user = User.create(params)
		success_or_error_for("sign_up", @user)
	end

	get "/sign_in" do
		erb :sign_in
	end

	post "/sign_in" do
		@user = sign_in(params[:email], params[:password]) 	
		success_or_error_for("sign_in",@user)

	end

	get '/edit_user' do
		unless @user # do this if a user isn't logged in
			flash[:notice] = "Sorry, you need to sign in or sign up before doing that."
			redirect '/users/sign_up'
		end
		erb :edit_user
	end

	post '/edit_user' do
		@user.update(params)
		success_or_error_for("edit_user",@user)
	end

	delete '/' do
		flash[:notice] = "Good bye!"
		session[:user_id] = nil
		redirect '/'
	end

end





