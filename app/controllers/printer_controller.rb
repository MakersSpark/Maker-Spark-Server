require_relative "../server.rb"

class PrinterController < SparkPrint


    post "/print" do 
      printer = Printer.new
      flash[:notice] = printer.print_line(["TEXT", params[:messagebox]])
      redirect '/'
    end
end