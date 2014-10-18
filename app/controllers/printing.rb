post "/" do    
  card_info = JsonHandler.get_user_info(params[:data]) 
     user = User.first(rfid_code: card_info["data"])
     event = EventHandler.new(card_info)
     if user
          event.build_message
          message = UserMessage.first(user_id: user.id)
          event.build_user_message(message.content,user.github_name) if message
     else
      event.build_rfid_url_message
     end  
     event.print_message(Printer.new)
     "sorry ben is stupid"
end

post "/print" do 
  printer = Printer.new
  flash[:notice] = printer.print_line(["TEXT", params[:messagebox]])
  redirect '/'
end

post "/send_message" do
     receiver = User.first(github_user: params[:receiver])
     message = UserMessage.create(content: params[:usermessagebox], sender_id: current_user.id, user_id: receiver.id)
     if message.save     
          flash[:notice] = "Message has been sent!"
     else
          flash[:notice] = "There has been a problem with your message!"
     end
     redirect '/'
end

