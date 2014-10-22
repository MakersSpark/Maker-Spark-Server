require_relative "../server.rb"

class PrinterController < SparkPrint


    post "/print" do 
      printer = Printer.new
      flash[:notice] = printer.print_line({format:"TEXT", text: params[:messagebox]})
      2.times { printer.print_blank_line }
      redirect '/'
    end
    
end