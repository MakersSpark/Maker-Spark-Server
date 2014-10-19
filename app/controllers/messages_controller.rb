require_relative "../server.rb"

class MessagesController < SparkPrint

	post "/new" do
       receiver = User.first(github_user: params[:receiver])
       message = UserMessage.create(content: params[:usermessagebox], sender_id: current_user.id, user_id: receiver.id)
       message_flash_notice(message)
       redirect '/'
	end

end

