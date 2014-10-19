require_relative "../server.rb"

class PrinterController < SparkPrint
    post "/" do 
      card_info = JsonHandler.get_user_info(params[:data]) 
      user = User.first(rfid_code: card_info["data"])
      event = EventHandler.new(card_info, user)
      event.build_message           
      event.print_message(Printer.new)
      "sorry ben is stupid"
    end

    post "/print" do 
      printer = Printer.new
      flash[:notice] = printer.print_line(["TEXT", params[:messagebox]])
      redirect '/'
    end

    get "/" do 
      "hello from the print contro"
    end

end