require_relative "../server.rb"

class MessagesController < SparkPrint

	post "/new" do 
       receiver = User.first(github_user: params[:receiver])
       if receiver
       		message = UserMessage.create(content: params[:usermessagebox], sender_id: current_user.id, user_id: receiver.id)
       		message_flash_notice(message)
       else 
      		flash[:notice] = "Please choose a user to receive your message."
   	   end
   	   redirect '/'
	end

end

