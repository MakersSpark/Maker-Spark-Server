module MessageHelper

	def message_notice(message) 
 		if message.save     
            flash[:notice] = "Message has been sent!"
       else
            flash[:notice] = "There has been a problem with your message!"
       end	
   end

end