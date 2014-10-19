require "./app/server"
Dir.glob('./app/{models,helpers,controllers}/*.rb').each { |file| require file }

map('/') { run SparkPrint }
map('/user') { run UsersController }
map('/printer') { run PrinterController }

