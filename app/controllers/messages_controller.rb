require_relative "../server.rb"

class MessagesController < SparkPrint

	post "/new" do
       receiver = User.first(github_user: params[:receiver])
       message = UserMessage.create(content: params[:usermessagebox], sender_id: current_user.id, user_id: receiver.id)
       if message.save     
            flash[:notice] = "Message has been sent!"
       else
            flash[:notice] = "There has been a problem with your message!"
       end
       redirect '/'
	end

end

