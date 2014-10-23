module UserHelper

	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]			
	end

	def sign_in(email,password)
		user = User.authenticate(email,password)
		if user 
			session[:user_id] = user.id
			flash[:notice]  = "Welcome back, #{current_user.email}"
		else
			flash[:errors] = ["We couldn't find that email address – make sure it's typed correctly.", "There's something wrong with your password."]
		end
		user
	end

	def user_flash_notice(cause) 
		if cause == "sign_up"
			flash[:notice]    = "Thank you for registering, #{current_user.email}"
		elsif cause == "edit_user"
			flash[:notice] = "Your details have been successfully updated"
		end
	end

	def on_signup_page
		request.path_info == "/users/sign_up"
	end

	def success_or_error_for(cause,user)
		if cause == "sign_in"
			if user
				redirect '/dashboard'  		
			else
				redirect "/users/#{cause}"
			end
		else
			if user.save
				session[:user_id] = user.id
				puts "xxxxxx"*20
				user_preferences = Preferences.create(user_id: user.id)
				user_preferences.update(github_username: user.github_user)
				user_flash_notice(cause)			
				redirect '/dashboard'
			else
				flash[:errors] = @user.errors.full_messages
				redirect "/users/#{cause}" 
			end
		end
	end

end